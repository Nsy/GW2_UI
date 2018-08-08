-- ptBR localization

local function GWUseThisLocalization()
-- Create a global variable for the language strings
GwLocalization = {}

--Fonts
GwLocalization['FONT_NORMAL'] = 'Interface\\AddOns\\GW2_UI\\fonts\\menomonia.ttf' 
GwLocalization['FONT_BOLD'] = 'Interface\\AddOns\\GW2_UI\\fonts\\headlines.ttf' 
GwLocalization['FONT_NARROW'] = 'Interface\\AddOns\\GW2_UI\\fonts\\menomonia.ttf'
GwLocalization['FONT_NARROW_BOLD'] = 'Interface\\AddOns\\GW2_UI\\fonts\\menomonia.ttf'
GwLocalization['FONT_LIGHT'] = 'Interface\\AddOns\\GW2_UI\\fonts\\menomonia-italic.ttf'
GwLocalization['FONT_DAMAGE'] = 'Interface\\AddOns\\GW2_UI\\fonts\\headlines.ttf'

--Strings
GwLocalization["ACTION_BAR_FADE"] = "Ocultar Barra de Ações"
GwLocalization["ACTION_BAR_FADE_DESC"] = "Ocultar Barras de Ações adicionais quando fora de combate."
GwLocalization["ACTION_BARS_DESC"] = "Usar as Barras de Ações melhoradas pelo GW2 ui"
GwLocalization["ADV_CAST_BAR"] = "Barra de Conjuração Avançada"
GwLocalization["ADV_CAST_BAR_DESC"] = "Habilitar ou Desabilitar a Barra de Conjuração Avançada"
GwLocalization["AMOUNT_LOAD_ERROR"] = "Quantidade não pôde ser carregada"
GwLocalization["BANK_COMPACT_ICONS"] = "Ícones Compactos"
GwLocalization["BANK_EXPAND_ICONS"] = "Ícones Grandes"
GwLocalization["BUTTON_ASSIGNMENTS"] = "Atribuições dos Botões de Ação"
GwLocalization["BUTTON_ASSIGNMENTS_DESC"] = "Habilitar ou Desabilitar as atribuições dos Botões de Ação"
GwLocalization["CASTING_BAR_DESC"] = "Habilitar a Barra de Conjuração estilo GW2"
GwLocalization["CHARACTER_NEXT_RANK"] = "PRÓXIMO"
GwLocalization["CHARACTER_NOT_LOADED"] = "Não carregado."
GwLocalization["CHARACTER_OUTFITS_DELETE"] = "Tem certeza que deseja deletar a vestimenta?"
GwLocalization["CHARACTER_OUTFITS_SAVE"] = "Tem certeza que deseja salvar a vestimenta?"
GwLocalization["CHARACTER_PARAGON"] = "Paragon"
GwLocalization["CHARACTER_REPUTATION_TRACK"] = "Mostrar como uma barra"
GwLocalization["CHAT_BUBBLES"] = "Balões de Conversa"
GwLocalization["CHAT_BUBBLES_DESC"] = "Substituir os Balões de conversa da UI padrão"
GwLocalization["CHAT_FADE"] = "Ocultar conversa"
GwLocalization["CHAT_FADE_DESC"] = "Permitir que a conversa seja ocultada quando não estiver em uso."
GwLocalization["CHAT_FRAME_DESC"] = "Habilitar janela de conversa aprimorada."
GwLocalization["CHRACTER_WINDOW_DESC"] = "Substituir a janela de personagem padrão."
GwLocalization["CLASS_COLOR_DESC"] = "Mostrar a cor da classe como barra de vida."
GwLocalization["CLASS_COLOR_RAID_DESC"] = "Usar a cor da classe em vez dos ícones das classes."
GwLocalization["CLASS_POWER"] = "Recurso da Classe"
GwLocalization["CLASS_POWER_DESC"] = "Habilitar os recursos de classe alternativos."
GwLocalization["CLICK_TO_TRACK"] = "Clique para rastrear"
GwLocalization["COMPACT_ICONS"] = "Ícones Compactos"
GwLocalization["COMPASS_TOGGLE"] = "Habilitar Bússola"
GwLocalization["COMPASS_TOGGLE_DESC"] = "Habilitar ou desabilitar a bússola do rastreador de missões."
GwLocalization["DAMAGED_OR_BROKEN_EQUIPMENT"] = "Equipamento danificado ou quebrado"
GwLocalization["DEBUFF_DISPELL_DESC"] = "Mostra apenas os efeitos negativos que você é capaz de remover."
GwLocalization["DYNAMIC_HUD"] = "Interface dinâmica"
GwLocalization["DYNAMIC_HUD_DESC"] = "Habilitar ou desabilitar interface de fundo que se ajusta dinamicamente."
GwLocalization["EXP_BAR_TOOLTIP_EXP_RESTED"] = "Descansado "
GwLocalization["EXP_BAR_TOOLTIP_EXP_RESTING"] = " (Descansando)"
GwLocalization["EXPAND_ICONS"] = "Ícones Grandes"
GwLocalization["FOCUS_DESC"] = "Modificar as configurações da unidade do foco."
GwLocalization["FOCUS_FRAME_DESC"] = "Habilitar a substituição da unidade do alvo do foco."
GwLocalization["FOCUS_TARGET_DESC"] = "Mostrar a unidade do alvo do foco."
GwLocalization["FOCUS_TOOLTIP"] = "Editar as configurações da unidade do foco."
GwLocalization["FONTS"] = "Fontes"
GwLocalization["FONTS_DESC"] = "Substituir as fontes padrão pelas fontes do GW2 UI."
GwLocalization["GROUND_MARKER"] = "MM"
GwLocalization["GROUP_DESC"] = "Edite as opções de grupo e raide para se adaptar às suas necessidades."
GwLocalization["GROUP_FRAMES"] = "Unidades do Grupo"
GwLocalization["GROUP_FRAMES_DESC"] = "Substituir as unidades de grupo da interface padrão."
GwLocalization["GROUP_TOOLTIP"] = "Editar as configurações de grupo."
GwLocalization["HEALTH_GLOBE"] = "Globo de Vida"
GwLocalization["HEALTH_GLOBE_DESC"] = "Habilitar a substituição da barra de vida."
GwLocalization["HEALTH_PERCENTAGE_DESC"] = "Mostrar a vida como porcentagem. Pode substituir ou ser usada junto com o Valor de Vida."
GwLocalization["HEALTH_VALUE_DESC"] = "Mostrar vida como um valor numérico."
GwLocalization["HIDE_EMPTY_SLOTS"] = "Ocultar Espaços Vazios"
GwLocalization["HIDE_EMPTY_SLOTS_DESC"] = "Ocultar os espaços vazios das barras de ações."
GwLocalization["HUD_CAT"] = "Interface"
GwLocalization["HUD_CAT_1"] = "Interface"
GwLocalization["HUD_DESC"] = "Edite os módulos da Interface para maior customização."
GwLocalization["HUD_MOVE_ERR"] = "Você não pode mover elementos durante o combate!"
GwLocalization["HUD_SCALE"] = "Escala da Interface"
GwLocalization["HUD_SCALE_DESC"] = "Mudar o tamanho da Interface."
GwLocalization["HUD_SCALE_TINY"] = "Minúscula"
GwLocalization["HUD_TOOLTIP"] = "Editar os módulos da Interface."
GwLocalization["INVENTORY_FRAME_DESC"] = "Habilitar a interface de inventário unificado."
GwLocalization["LEVEL_REWARDS"] = "Recompensas dos Próximos Níveis"
GwLocalization["MAP_CLOCK_LOCAL_REALM"] = "Shift+Clique para alternar entre horário Local ou do Servidor"
GwLocalization["MAP_CLOCK_MILITARY"] = "Clique com Botão Esquerdo para habilitar horário em formato militar"
GwLocalization["MAP_CLOCK_STOPWATCH"] = "Clique com Botão Direito para abrir o Cronômetro"
GwLocalization["MINIMAP_DESC"] = "Usar a unidade de Minimapa do GW2 UI"
GwLocalization["MINIMAP_HOVER"] = "Detalhes do Minimapa"
GwLocalization["MINIMAP_HOVER_TOOLTIP"] = "Sempre mostrar detalhes do Minimapa."
GwLocalization["MINIMAP_SCALE"] = "Escala do Minimapa"
GwLocalization["MINIMAP_SCALE_DESC"] = "Alterar o tamanho do Minimapa."
GwLocalization["MODULES_CAT"] = "MÓDULOS"
GwLocalization["MODULES_CAT_1"] = "Módulos"
GwLocalization["MODULES_CAT_TOOLTIP"] = "Habilitar e desabilitar componentes"
GwLocalization["MODULES_DESC"] = "Habilite ou desabilite os módulos que você precisa ou não precisa."
GwLocalization["MODULES_TOOLTIP"] = "Habilitar ou desabilitar módulos da Interface."
GwLocalization['MOUSE_TOOLTIP'] = 'Tooltip mouse anchor'
GwLocalization['MOUSE_TOOLTIP_DESC'] = 'Show Tooltips at cursor'
GwLocalization["MOVE_HUD_BUTTON"] = "Mover Interface"
GwLocalization["NAME_LOAD_ERROR"] = "Nome não pôde ser carregado"
GwLocalization["NOT_A_LEGENDARY"] = "Você não pode aprimorar aquele item."
GwLocalization["PET_BAR_DESC"] = "Usar a barra de Pet aprimorada do GW2 UI."
GwLocalization["PLAYER_AURAS_DESC"] = "Mover e redimensionar as auras dos jogadores."
GwLocalization["POWER_BARS_RAID_DESC"] = "Exibe as barras de recursos nas unidades da raide."
GwLocalization["PROFILES_CAT"] = "PERFIS"
GwLocalization["PROFILES_CAT_1"] = "Perfis"
GwLocalization["PROFILES_CREATED"] = "Criado: "
GwLocalization["PROFILES_CREATED_BY"] = "\nCriado por: "
GwLocalization["PROFILES_DEFAULT_SETTINGS"] = "Configurações Padrão"
GwLocalization["PROFILES_DEFAULT_SETTINGS_DESC"] = "Carregar as configurações padrão do addon no perfil atual."
GwLocalization["PROFILES_DEFAULT_SETTINGS_PROMPT"] = "Tem certeza que deseja carregar as configurações padrão?\n\nTodas as configurações anteriores serão perdidas."
GwLocalization["PROFILES_DELETE"] = "Tem certeza que deseja deletar este perfil?"
GwLocalization["PROFILES_DESC"] = "Perfis são uma forma fácil de compartilhas suas configurações entre personagens e reinos."
GwLocalization["PROFILES_LAST_UPDATE"] = "\nÚltima atualização: "
GwLocalization["PROFILES_LOAD_BUTTON"] = "Carregar"
GwLocalization["PROFILES_MISSING_LOAD"] = "Se você vê esta mensagem, é porque esquecemos de carregar algum texto. Não se preocupe, nós temos bastante texto de amostra como este para mantê-lo informado."
GwLocalization["PROFILES_TOOLTIP"] = "Adicione e remova perfis."
GwLocalization["QUEST_REQUIRED_ITEMS"] = "Itens Necessários:"
GwLocalization["QUEST_TRACKER_DESC"] = "Habilitar o rastreador de missões remodelado e aprimorado."
GwLocalization["QUEST_VIEW_SKIP"] = "Pular"
GwLocalization["QUESTING_FRAME"] = "Missões Imersivas"
GwLocalization["QUESTING_FRAME_DESC"] = "Habilitar o modo de Missões Imersivas."
GwLocalization["RAID_BAR_HEIGHT"] = "Ajustar a Altura das Unidades de Raide"
GwLocalization["RAID_BAR_HEIGHT_DESC"] = "Ajustar a altura das unidades de raide."
GwLocalization["RAID_BAR_WIDTH"] = "Ajustar a Largura das Unidades de Raide"
GwLocalization["RAID_BAR_WIDTH_DESC"] = "Ajustar a largura das unidades de raide."
GwLocalization["RAID_CONT_HEIGHT"] = "Ajustar a Altura do Quadro da Raide"
GwLocalization["RAID_CONT_HEIGHT_DESC"] = "Ajuste a altura máxima com que as unidades de raide podem ser exibidas."
GwLocalization["RAID_MARKER_DESC"] = "Mostra os Marcadores Alvo nas Unidades da Raide"
GwLocalization["RAID_PARTY_STYLE_DESC"] = "Configura as unidades do grupo como unidades de raide."
GwLocalization["RAID_UNIT_FLAGS"] = "Mostrar bandeira do país"
GwLocalization["RAID_UNIT_FLAGS_2"] = "Diferentes do seu próprio"
GwLocalization["RAID_UNIT_FLAGS_TOOLTIP"] = "Mostrar a bandeira do país baseado no idioma da unidade"
GwLocalization["RESOURCE_DESC"] = "Substitui a barra de recurso/mana padrão."
GwLocalization["SETTING_LOCK_HUD"] = "Travar Interface"
GwLocalization["SETTINGS_BUTTON"] = "Configurações do GW2 UI"
GwLocalization["SETTINGS_NO_LOAD_ERROR"] = "Algum texto não foi carregado, por favor tente recarregar a interface."
GwLocalization["SETTINGS_RESET_TO_DEFAULT"] = "Resetar para o Padrão."
GwLocalization["SETTINGS_SAVE_RELOAD"] = "Salvar e Recarregar"
GwLocalization["SHOW_ALL_DEBUFFS_DESC"] = "Mostrar todos os efeitos negativos no alvo."
GwLocalization["SHOW_BUFFS_DESC"] = "Mostrar os efeitos positivos no alvo."
GwLocalization["SHOW_DEBUFFS_DESC"] = "Mostrar os efeitos negativos no alvo que foram causados por você."
GwLocalization["TARGET_DESC"] = "Modificar as configurações da unidade do alvo."
GwLocalization["TARGET_FRAME_DESC"] = "Habilitar a substituição da unidade do alvo."
GwLocalization["TARGET_OF_TARGET_DESC"] = "Habilitar a unidade do alvo do alvo."
GwLocalization["TARGET_TOOLTIP"] = "Editar as configurações da unidade do alvo."
GwLocalization["TOOLTIPS"] = "Descrições"
GwLocalization["TOOLTIPS_DESC"] = "Substituir as descrições da Interface padrão."
GwLocalization["TRACKER_RETRIVE_CORPSE"] = "Retorne ao seu corpo"
GwLocalization["UNEQUIP_LEGENDARY"] = "Você precisar desequipar aquele item para poder aprimorá-lo."
GwLocalization["UPDATE_STRING_1"] = "Nova atualização disponível para download."
GwLocalization["UPDATE_STRING_2"] = "Nova atualização disponível com características novas."
GwLocalization["UPDATE_STRING_3"] = "Uma atualização |cFFFF0000maior|r está disponível.\nÉ altamente recomendado que você atualize."
GwLocalization['BAG_SORT_ORDER_FIRST'] = 'Sort to First Bag'
GwLocalization['BAG_SORT_ORDER_LAST'] = 'Sort to Last Bag'
GwLocalization['BAG_NEW_ORDER_FIRST'] = 'New Items to First Bag'
GwLocalization['BAG_NEW_ORDER_LAST'] = 'New Items to Last Bag'
GwLocalization['BAG_ORDER_NORMAL'] = 'Normal Bag Order'
GwLocalization['BAG_ORDER_REVERSE'] = 'Reverse Bag Order'
GwLocalization['STG_RIGHT_BAR_COLS'] = 'Right Bar Width'
GwLocalization['STG_RIGHT_BAR_COLS_DESC'] = 'Number of columns in the two extra right-hand action bars.'
GwLocalization['DISABLED_MA_BAGS'] = "Disabled MoveAnything's bag handling."
GwLocalization['FADE_MICROMENU'] = 'Fade Menu Bar'
GwLocalization['FADE_MICROMENU_DESC'] = 'Fade the main micromenu when the mouse is not near.'
GwLocalization['TALENTS_BUTTON_DESC'] = 'Enable the talents, specialization, and spellbook replacement.' 
GwLocalization['ALL_BINDINGS_SAVE'] = "All key bindings have been saved."
GwLocalization['ALL_BINDINGS_DISCARD'] = "All newly set key bindings have been discarded."
GwLocalization['BINDINGS_DESC'] = "Hover your mouse over any actionbutton to bind it. Press the escape key or right click to clear the current actionbutton's keybinding." 
GwLocalization['BINDINGS_TRIGGER'] = "Trigger"
GwLocalization['BINGSINGS_KEY'] = "Key"
GwLocalization['BINGSINGS_CLEAR'] = "All key bindings cleared for"
GwLocalization['BINGSINGS_BIND'] = "bound to"
end


if GetLocale() == "ptBR" then
	GWUseThisLocalization()
end

-- After using this localization or deciding that we don"t need it, remove it from memory.
GWUseThisLocalization = nil