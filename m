Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262183AbVCUXCc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262183AbVCUXCc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 18:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262179AbVCUW71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 17:59:27 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:63113 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262124AbVCUW4d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 17:56:33 -0500
Date: Mon, 21 Mar 2005 23:56:20 +0100
From: Pavel Machek <pavel@suse.cz>
To: Mws <mws@twisted-brains.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2/2] SquashFS
Message-ID: <20050321225620.GT1390@elf.ucw.cz>
References: <20050314170653.1ed105eb.akpm@osdl.org> <423727BD.7080200@grupopie.com> <20050321101441.GA23456@elf.ucw.cz> <200503211908.46602.mws@twisted-brains.org> <20050321185418.GC1390@elf.ucw.cz> <423F496C.10004@twisted-brains.org> <20050321223146.GM1390@elf.ucw.cz> <423F4F1F.3010905@twisted-brains.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <423F4F1F.3010905@twisted-brains.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >I should have added a smiley.
> >
> >I'm not seriously suggesting that it contains deliberate problem. But
> >codestyle uglyness and arbitrary limits may come back and haunt us in
> >future. Once code is in kernel, it is very hard to change on-disk
> >format, for example.
> >
> yes, i agree at that point. but, there are many people using this 
> already and if it will _not_ become merged to
> mainline kernel, maybe these portions of code will get lost.

I don't believe source code ever get lost. Actually, I wish some
source code *would* get lost, like fs/umsdos for example ;-).

								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
