function [count] = face_vertex_data_unequal_npoints(fid, faces, points,...
                                        normals, face_vertex_data)
[face_vertex_data_unique, tmp, face_vertex_data_idx] = ...
                                unique(face_vertex_data, 'rows');
nface_vertex_data_unique = size(face_vertex_data_unique,1);

str = node_resource_list_str;
count = fprintf(fid, str, nfaces, npoints, npoints, nface_vertex_data_unique);

idx = [0:(nfaces-1)]';
shidx = [0:(nface_vertex_data_unique-1)]';
str = shading_description_str;
count = fprintf(fid,str,[shidx,shidx]');

str = mesh_data_str;

strfaces = sprintf('%d %d %d\n',faces'-1);
strpoints = sprintf('%f %f %f\n',points');
strnormals = sprintf('%f %f %f\n',normals');
% stridx = sprintf('%d\n',idx);
str_face_vertex_data_idx = sprintf('%d\n',face_vertex_data_idx-1);
count = fprintf(fid,str,strfaces,strfaces,str_face_vertex_data_idx,strpoints,strnormals,nface_vertex_data_unique);

str = resource_str;
count = fprintf(fid,str,[shidx,shidx,shidx]');

str = resource_list_material_str;
count = fprintf(fid,str,nface_vertex_data_unique);

str = verbatim;
%{
     RESOURCE %d {
          RESOURCE_NAME "Box01%d"
          MATERIAL_AMBIENT 0 0 0
          MATERIAL_DIFFUSE %f %f %f
          MATERIAL_SPECULAR 0.2 0.2 0.2
          MATERIAL_EMISSIVE 0 0 0
          MATERIAL_REFLECTIVITY 0.100000
          MATERIAL_OPACITY 1.000000
     }

%}
count = fprintf(fid,str,[shidx,shidx,face_vertex_data_unique]');

str = modifier_shading_str;
count = fprintf(fid,str,nface_vertex_data_unique);

str = shader_list_str;
count = fprintf(fid,str,[shidx,shidx]');

str = verbatim;
%{
          }
     }
}

%}
count = fprintf(fid,str);

function [str] = node_resource_list_str
str = verbatim;
%{
FILE_FORMAT "IDTF"
FORMAT_VERSION 100

NODE "MODEL" {
     NODE_NAME "Mesh"
     PARENT_LIST {
          PARENT_COUNT 1
          PARENT 0 {
               PARENT_NAME "<NULL>"
               PARENT_TM {
                    1.000000 0.000000 0.000000 0.000000
                    0.000000 1.000000 0.000000 0.000000
                    0.000000 0.000000 1.000000 0.000000
                    0.000000 0.000000 0.000000 1.000000
               }
          }
     }
     RESOURCE_NAME "MyMesh"
}

RESOURCE_LIST "MODEL" {
     RESOURCE_COUNT 1
     RESOURCE 0 {
          RESOURCE_NAME "MyMesh"
          MODEL_TYPE "MESH"
          MESH {
               FACE_COUNT %d
               MODEL_POSITION_COUNT %d
               MODEL_NORMAL_COUNT %d
               MODEL_DIFFUSE_COLOR_COUNT 0
               MODEL_SPECULAR_COLOR_COUNT 0
               MODEL_TEXTURE_COORD_COUNT 0
               MODEL_BONE_COUNT 0
               MODEL_SHADING_COUNT %d
               MODEL_SHADING_DESCRIPTION_LIST {

%}

function [str] = shading_description_str
str = verbatim;
%{
            SHADING_DESCRIPTION %d {
                     TEXTURE_LAYER_COUNT 0
                     SHADER_ID %d
                }

%}

function [str] = mesh_data_str
str = verbatim;
%{
               }
               MESH_FACE_POSITION_LIST {
                    %s
               }
               MESH_FACE_NORMAL_LIST {
                    %s
               }
               MESH_FACE_SHADING_LIST {
                    %s
               }
               MODEL_POSITION_LIST {
                    %s
               }
               MODEL_NORMAL_LIST {
                    %s
               }
          }
     }
}

RESOURCE_LIST "SHADER" {
     RESOURCE_COUNT %d

%}

function [str] = resource_str
str = verbatim;
%{
     RESOURCE %d {
          RESOURCE_NAME "Box01%d"
          SHADER_MATERIAL_NAME "Box01%d"
          SHADER_ACTIVE_TEXTURE_COUNT 0
    }

%}

function [str] = resource_list_material_str
str = verbatim;
%{
}

RESOURCE_LIST "MATERIAL" {
     RESOURCE_COUNT %d

%}

function [str] = modifier_shading_str
str = verbatim;
%{
}

MODIFIER "SHADING" {
     MODIFIER_NAME "Mesh"
     PARAMETERS {
          SHADER_LIST_COUNT %d
          SHADER_LIST_LIST {

%}

function [str] = shader_list_str
str = verbatim;
%{
               SHADER_LIST %d {
                    SHADER_COUNT 1
                    SHADER_NAME_LIST {
                         SHADER 0 NAME: "Box01%d"
                    }
               }

%}