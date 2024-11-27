CREATE TABLE
    ooni.jsonl (
        `report_id` String,
        `input` String,
        `s3path` String,
        `linenum` Int32,
        `measurement_uid` String,
        `date` Date,
        `source` String,
        `update_time` DateTime64 (3) MATERIALIZED now64 ()
    ) ENGINE = ReplicatedReplacingMergeTree (
        '/clickhouse/{cluster}/tables/ooni/jsonl/{shard}',
        '{replica}',
        update_time
    )
ORDER BY
    (report_id, input, measurement_uid) SETTINGS index_granularity = 8192;

CREATE TABLE
    ooni.fastpath (
        `measurement_uid` String,
        `report_id` String,
        `input` String,
        `probe_cc` LowCardinality (String),
        `probe_asn` Int32,
        `test_name` LowCardinality (String),
        `test_start_time` DateTime,
        `measurement_start_time` DateTime,
        `filename` String,
        `scores` String,
        `platform` String,
        `anomaly` String,
        `confirmed` String,
        `msm_failure` String,
        `domain` String,
        `software_name` String,
        `software_version` String,
        `control_failure` String,
        `blocking_general` Float32,
        `is_ssl_expected` Int8,
        `page_len` Int32,
        `page_len_ratio` Float32,
        `server_cc` String,
        `server_asn` Int8,
        `server_as_name` String,
        `update_time` DateTime64 (3) MATERIALIZED now64 (),
        `test_version` String,
        `architecture` String,
        `engine_name` LowCardinality (String),
        `engine_version` String,
        `test_runtime` Float32,
        `blocking_type` String,
        `test_helper_address` LowCardinality (String),
        `test_helper_type` LowCardinality (String),
        `ooni_run_link_id` Nullable (UInt64),
        INDEX fastpath_rid_idx report_id TYPE minmax GRANULARITY 1,
        INDEX measurement_uid_idx measurement_uid TYPE minmax GRANULARITY 8
    ) ENGINE = ReplicatedReplacingMergeTree (
        '/clickhouse/{cluster}/tables/ooni/fastpath/{shard}',
        '{replica}',
        update_time
    )
ORDER BY
    (
        measurement_start_time,
        report_id,
        input,
        measurement_uid
    ) SETTINGS index_granularity = 8192;

CREATE TABLE
    ooni.citizenlab (
        `domain` String,
        `url` String,
        `cc` FixedString (32),
        `category_code` String
    ) ENGINE = ReplicatedReplacingMergeTree (
        '/clickhouse/{cluster}/tables/ooni/citizenlab/{shard}',
        '{replica}'
    )
ORDER BY
    (domain, url, cc, category_code) SETTINGS index_granularity = 4;

CREATE TABLE
    ooni.citizenlab_flip (
        `domain` String,
        `url` String,
        `cc` FixedString (32),
        `category_code` String
    ) ENGINE = ReplicatedReplacingMergeTree (
        '/clickhouse/{cluster}/tables/ooni/citizenlab_flip/{shard}',
        '{replica}'
    )
ORDER BY
    (domain, url, cc, category_code) SETTINGS index_granularity = 4;