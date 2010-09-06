{*
 *  blob.tpl
 *  gitphp: A PHP git repository browser
 *  Component: Blob view template
 *
 *  Copyright (C) 2009 Christopher Han <xiphux@gmail.com>
 *}

 {include file='header.tpl'}

 <div class="page_nav">
   <a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&a=summary">summary</a> | <a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&a=shortlog">shortlog</a> | <a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&a=log">log</a> | <a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&a=commit&h={$commit->GetHash()}">commit</a> | <a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&a=commitdiff&h={$commit->GetHash()}">commitdiff</a> | <a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&a=tree&h={$tree->GetHash()}&hb={$commit->GetHash()}">tree</a><br />
   <a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&a=blob_plain&h={$blob->GetHash()}&f={$blob->GetPath()}">plain</a> | 
   {if ($commit->GetHash() != $head->GetHash()) && ($head->PathToHash($blob->GetPath()))}
     <a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&a=blob&hb=HEAD&f={$blob->GetPath()}">HEAD</a>
   {else}
     HEAD
   {/if}
   {if !$datatag} | <a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&a=blame&h={$blob->GetHash()}&f={$blob->GetPath()}&hb={$commit->GetHash()}" id="blameLink">blame</a>{/if}
   <br />
 </div>

 {include file='title.tpl' titlecommit=$commit}

{include file='path.tpl' pathobject=$blob target='blobplain'}

 <div class="page_body">
   {if $datatag}
     {* We're trying to display an image *}
     <div>
       <img src="data:{$mime};base64,{$data}" />
     </div>
   {elseif $geshi}
     {* We're using the highlighted output from geshi *}
     {$geshiout}
   {else}
     {* Just plain display *}
     <table class="code" id="blobData">
     {foreach from=$bloblines item=line name=bloblines}
       <tr>
         <td class="num"><a id="l{$smarty.foreach.bloblines.iteration}" href="#l{$smarty.foreach.bloblines.iteration}" class="linenr">{$smarty.foreach.bloblines.iteration}</a></td>
	 <td class="codeline">{$line|escape}</td>
       </tr>
     {/foreach}
     </table>
   {/if}
 </div>

 {include file='footer.tpl'}
