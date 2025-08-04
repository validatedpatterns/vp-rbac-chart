{{- /* Helper to add a default * entries for rules that do not define apiGroups/resources/verbs  and render them as yaml */}}

{{- define "vp-rbac.rulesHelper" -}}
{{- $rules := index . 0 -}}

{{- range $index, $rule := $rules }}

{{- if not (hasKey $rule "apiGroups") }}
apiGroups: [ '*' ]
{{- else }}
{{ $rule.apiGroups | toYaml }}
{{- end }}

{{- if not (hasKey $rule "resources") }}
resources: [ '*' ]
{{- else }}
{{ $rule.resources | toYaml }}
{{- end }}

{{- if not (hasKey $rule "verbs") }}
verbs: [ '*' ]
{{- else }}
{{ $rule.verbs | toYaml }}
{{- end }}

{{- end }} {{/* end range $rules */}}
{{- end -}} {{/* end define */}}
