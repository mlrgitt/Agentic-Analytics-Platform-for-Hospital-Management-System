{% macro dynamic_select(relation) %}

    {% set columns = adapter.get_columns_in_relation(relation) %}

    {% for col in columns %}
        {{ col.name }}
        {% if not loop.last %}, {% endif %}
    {% endfor %}

{% endmacro %}