Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262143AbVCUWsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262143AbVCUWsz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 17:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262117AbVCUWrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 17:47:17 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:37058 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262155AbVCUWoV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 17:44:21 -0500
Date: Mon, 21 Mar 2005 23:44:03 +0100
From: Pavel Machek <pavel@suse.cz>
To: Mws <mws@twisted-brains.org>
Cc: Phillip Lougher <phillip@lougher.demon.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2/2] SquashFS
Message-ID: <20050321224403.GP1390@elf.ucw.cz>
References: <20050314170653.1ed105eb.akpm@osdl.org> <A572579D-94EF-11D9-8833-000A956F5A02@lougher.demon.co.uk> <20050314190140.5496221b.akpm@osdl.org> <423727BD.7080200@grupopie.com> <20050321101441.GA23456@elf.ucw.cz> <423EEEC2.9060102@lougher.demon.co.uk> <20050321190044.GD1390@elf.ucw.cz> <423F4B88.8020504@twisted-brains.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <423F4B88.8020504@twisted-brains.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

[I'm not sure if I should further feed the trolls.]

> >Yes, it *is* rather unfair. Sorry about that. But having 2 different
> >limited compressed filesystems in kernel does not seem good to me.

> what do you need e.g. reiserfs 4 for? or jfs? or xfs? does not ext2/3 
> the journalling job also?
> is there really a need for cifs and samba and ncpfs and nfs v3 and nfs 
> v4? why?

Take a look at debate that preceded xfs merge. And btw reiserfs4 is
*not* merged.

And people merging xfs/reiserfs4/etc did address problems pointed out
in their code.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
