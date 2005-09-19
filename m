Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932646AbVISXQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932646AbVISXQp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 19:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932640AbVISXQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 19:16:45 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:40407 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932626AbVISXQo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 19:16:44 -0400
Date: Tue, 20 Sep 2005 01:15:38 +0200
From: Pavel Machek <pavel@suse.cz>
To: Petr Baudis <pasky@suse.cz>
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Cogito-0.15
Message-ID: <20050919231538.GA4074@elf.ucw.cz>
References: <7vr7c02zgg.fsf@assigned-by-dhcp.cox.net> <7vwtleyml5.fsf@assigned-by-dhcp.cox.net> <20050919011428.GF22391@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050919011428.GF22391@pasky.or.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>   this is the release of Cogito-0.15. It fixes several minor bugs, and
> adds a feature or two. The most important thing though is that this
> depends on Git-core-0.99.7 and uses the new command names. Everyone is
> encouraged to upgrade at least to this Cogito version in the next few
> days, since the older Cogito versions likely won't work with the future
> Git-core releases.
> 
>   To stay in sync with the Git terminology, Cogito also renames its
> cg-pull to cg-fetch. Since this is a major naming change (I'm not too
> happy about it, personally), cg-pull will stay aliased to cg-fetch for
> at least one (likely two) next major Cogito releases (it also produces a
> warning when invoked as cg-pull). In the more distant future, cg-pull
> will slowly become the new name of cg-update, to make it confusing.

Could we keep at least the cg-update name? It is certainly not a
*pull* because it does update local repository (and tree, too).

								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
