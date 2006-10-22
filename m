Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422985AbWJVH4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422985AbWJVH4Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 03:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422953AbWJVH4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 03:56:25 -0400
Received: from main.gmane.org ([80.91.229.2]:49341 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1423130AbWJVH4Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 03:56:25 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Mailing lists (again, was ANNOUNCEMENT: Real-time Linux users list created)
Date: Sun, 22 Oct 2006 07:56:12 +0000 (UTC)
Organization: Palacky University in Olomouc, experimental physics department.
Message-ID: <slrnejm9d6.30t.olecom@flower.upol.cz>
References: <E1GawZH-0002l3-FG@candygram.thunk.org>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: flower.upol.cz
Mail-Followup-To: Oleg Verych <olecom@flower.upol.cz>, LKML <linux-kernel@vger.kernel.org>
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo, Theodore.

On 2006-10-20, Theodore Ts'o wrote:
>
> 	We have created a list for users of CONFIG_PREEMPT_RT,
> linux-rt-users@vger.kernel.org.   It is archived on gmane.org (and of
> course people who want to read it via gmane's NNTP or RSS feeds can do
> so as well): 
>
> 	http://gmane.org/info.php?group=gmane.linux.rt.user

Could you, please, explain why this new list and LKML add that
(imho silly) messages in every post? (e.g.):
.____
|-
|To unsubscribe from this list: send the line "unsubscribe
|linux-rt-users" in
|the body of a message to majordomo@vger.kernel.org
|More majordomo info at  http://vger.kernel.org/majordomo-info.html
`----

Why not to use something like this in the headers?

,--
|List-Post: <mailto:XXX-kernel@lists.ZZZZ.org>
|List-Help: <mailto:XXX-kernel-request@lists.ZZZZ.org?subject=help>
|List-Subscribe: <mailto:XXX-kernel-request@lists.ZZZZ.org?subject=su...
|List-Unsubscribe: <mailto:XXX-kernel-request@lists.ZZZZ.org?subject=un...
`--

I think everybody, who wants to use the list, may find info; in the
message's headers one may (and should) find even more info on how to
use, manage, configure the list.
IMHO store this in information body of a message, is useless payload.

Thankfully to mister Gooch, lkml faq was updated last August,
and every lkml's message doesn't point to a document, where first
word was: obsolete, any more. (maybe nobody saw that, but update with
"obsolete" was there)

=[OT/2]=

Also, i really want to know why switch from Usenet to LKML occurred.
Maybe there were problems with Usenet, but author of gmane.org, mr.
Lars Magne Ingebrigtsen, let me (and you) to use MLs as naturally as
news, described in rfc 977. It also helps us to achieve *goals* of news
system (rfc 977, 1.1). And, btw, he doesn't have sponsored hardware and
bandwidth form big IT.

If you will send me to archives without exact url or message-id,
i'll say: thank you very much (thinking about something other ;).

Really, web is a big PITA: searching archives of 90th, xmlandards and
web-clients, browsers (-fsck-, mkfs them all).

Developers are saying about "plain text", no MIME, < 80 wide lines
(other netiquette things), talking about SP@M in the LKML: all this
isn't natural for gmane.org-news, as far as i can see.

Consider SP@M, for example. I don't know what kind of it was in usenet
time, but now it's obviously @-based, and requiring valid e-mail address
is OK as for news, as for e-mail posts.

TIA.
____

