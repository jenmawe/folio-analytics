DROP TABLE IF EXISTS local.instances_electronic_access;

-- Create table for electronic access points for instance records
CREATE TABLE local.instances_electronic_access AS
SELECT
    instance.id AS instance_id,
    instance.hrid AS instance_hrid,
    json_extract_path_text(electronic_access.data, 'linkText') AS link_text,
    json_extract_path_text(electronic_access.data, 'materialsSpecification') AS materials_specification,
    json_extract_path_text(electronic_access.data, 'publicNote') AS public_note,
    json_extract_path_text(electronic_access.data, 'relationshipId') AS relationship_id,
    inventory_instance_relationship_types.name AS relationship_type_id_name,
    json_extract_path_text(electronic_access.data, 'uri') AS uri
FROM
    inventory_instances AS instance
    CROSS JOIN json_array_elements(json_extract_path(data, 'electronicAccess')) AS electronic_access(data)
    LEFT JOIN inventory_instance_relationship_types ON json_extract_path_text(electronic_access.data, 'relationshipId') = inventory_instance_relationship_types.id;

CREATE INDEX ON local.instances_electronic_access (instance_id);

CREATE INDEX ON local.instances_electronic_access (instance_hrid);

CREATE INDEX ON local.instances_electronic_access (link_text);

CREATE INDEX ON local.instances_electronic_access (materials_specification);

CREATE INDEX ON local.instances_electronic_access (public_note);

CREATE INDEX ON local.instances_electronic_access (relationship_id);

CREATE INDEX ON local.instances_electronic_access (relationship_type_id_name);

CREATE INDEX ON local.instances_electronic_access (uri);

VACUUM local.instances_electronic_access;

ANALYZE local.instances_electronic_access;

