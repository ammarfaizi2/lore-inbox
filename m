Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261436AbVALVEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261436AbVALVEL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 16:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbVALVD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 16:03:28 -0500
Received: from gprs214-252.eurotel.cz ([160.218.214.252]:4529 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261436AbVALU5I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 15:57:08 -0500
Date: Wed, 12 Jan 2005 21:56:51 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: kinema@gmail.com, fuse-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Subject: Re: [fuse-devel] Merging?
Message-ID: <20050112205651.GI1408@elf.ucw.cz>
References: <loom.20041231T155940-548@post.gmane.org> <E1ClQi2-0004BO-00@dorka.pomaz.szeredi.hu> <E1CoisR-0001Hi-00@dorka.pomaz.szeredi.hu> <20050112194408.GB1464@openzaurus.ucw.cz> <E1CopDd-0002dh-00@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CopDd-0002dh-00@localhost>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I like fuse, but I do not think Linus and Akpm have enough mails
> > already. Getting it merged to some distribution might do the
> > trick....
> 
> I know debian and gentoo already carry packages.  It doesn't get it
> closer to inclusion though.

Does Debian carry kernel patched with FUSE patches by default?

								Pavel
PS: IIRC and not speaking for suse: I think suse was seriously
thinking about using FUSE by default. It did not work well enough back
then. Not sure who exactly was working on it...
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
