{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "fullname" -}}
{{- printf "%s" .Release.Name -}}
{{- end -}}

{{/* Tolerations template for Argus. */}}
{{- define "argus.tolerations" -}}
    {{- range .Values.tolerations }}
      {{- if and (eq .operator "Exists") (ne .value "") }}
          {{- fail "Value must be empty when 'operator' is 'Exists'"}}
      {{- else if and (ne .operator "Exists") (eq .key "") }}
          {{- fail "Operator must be 'Exists' when 'key' is empty." }}
      {{- else if and (ne .effect "NoExecute") (.tolerationSeconds)}}
          {{- fail "Effect must be 'NoExecute' when 'tolerationSeconds' is set." }}
      {{- else }}
      - key: {{ .key | quote }}
        value: {{ .value | quote }}
        operator: {{ .operator | quote }}
        effect: {{ .effect | quote }}
        tolerationSeconds: {{ .tolerationSeconds }}
      {{- end }}
    {{- end }}
{{- end -}}

{{/* Tolerations template for collectorset. */}}
{{- define "collectorset.tolerations" -}}
{{- range .Values.collector.tolerations }}
  {{- if and (eq .operator "Exists") (ne .value "") }}
    {{- fail "Value must be empty when 'operator' is 'Exists'"}}
  {{- else if and (ne .operator "Exists") (eq .key "") }}
    {{- fail "Operator must be 'Exists' when 'key' is empty." }}
  {{- else if and (ne .effect "NoExecute") (.tolerationSeconds)}}
    {{- fail "Effect must be 'NoExecute' when 'tolerationSeconds' is set." }}
  {{- else }}
  - key: {{ .key | quote }}
    value: {{ .value | quote }}
    operator: {{ .operator | quote }}
    effect: {{ .effect | quote }}
    tolerationSeconds: {{ .tolerationSeconds }}
  {{- end }}
{{- end }}
{{- end -}}
