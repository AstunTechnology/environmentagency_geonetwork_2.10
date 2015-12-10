from nose.tools import eq_
from resetpasswd import parse_config, build_conn_args


def test_build_conn_args():
    expected_args = {'user': 'wendy', 'host': 'geonetwork.example.com', 'password': 'xxxxxxxx', 'port': '5432', 'database': 'geonetwork'}
    postgres_url = 'jdbc:postgresql://geonetwork.example.com:5432/geonetwork'
    postgres_args = build_conn_args(postgres_url, 'wendy', 'xxxxxxxx')
    assert cmp(postgres_args, expected_args) == 0
    postgis_url = 'jdbc:postgresql_postGIS://geonetwork.example.com:5432/geonetwork'
    postgis_args = build_conn_args(postgis_url, 'wendy', 'xxxxxxxx')
    assert cmp(postgis_args, expected_args) == 0


def test_parse_config():
    expected_config = {'db_pass': 'xxxxxxxx', 'db_user': 'geonetwork', 'db_url': 'jdbc:postgresql://localhost:5432/geonetwork'}
    config = parse_config('./test/fixtures/config.xml', './properties/')
    eq_(cmp(config, expected_config), 0)
