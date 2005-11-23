Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbVKWMDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbVKWMDE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 07:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbVKWMDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 07:03:04 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:38812 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750710AbVKWMDC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 07:03:02 -0500
Date: Wed, 23 Nov 2005 13:02:48 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Lorenzo Colitti <lorenzo@colitti.com>
Cc: Nigel Cunningham <ncunningham@cyclades.com>, Greg KH <greg@kroah.com>,
       Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [RFC] userland swsusp
Message-ID: <20051123120248.GB18403@elf.ucw.cz>
References: <20051115233201.GA10143@elf.ucw.cz> <1132115730.2499.37.camel@localhost> <20051116061459.GA31181@kroah.com> <1132120845.25230.13.camel@localhost> <20051116165023.GB5630@kroah.com> <1132171051.25230.53.camel@localhost> <20051116213517.GD12505@elf.ucw.cz> <1132175248.25230.104.camel@localhost> <20051116224728.GI12505@elf.ucw.cz> <4384417B.9040201@colitti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4384417B.9040201@colitti.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On St 23-11-05 11:16:27, Lorenzo Colitti wrote:
> Pavel Machek wrote:
> >Yes, hopefully users will not notice.
> 
> ? So the idea is to merge inferior code and "hope users won't notice"?
> 
> Users  might not notice that half their memory is gone, but they *will* 
> notice that their system is dog slow when it resumes because all their 
> caches are gone and a most of their stuff is swapped out.
> 
> Non-responsive system on resume is one of the main reasons that swsusp2 
> is much better than swsusp1, and yes, users *do* notice (I was one of 
> them, as I pointed out a while back). Yes, 50% is better than nothing, 
> but it's still a pretty poor show.

Did you actually benchmark it?

> Seen from the perspective of a user, the situation is simple: suspend2 
> works, it's fast, and it's rock-solid. Just use it.

About as helpful as "Windows XP works, it's fast, and it's
rock-solid".

							Pavel
-- 
Thanks, Sharp!
