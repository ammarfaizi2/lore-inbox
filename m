Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262304AbVCILOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262304AbVCILOl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 06:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262300AbVCILOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 06:14:40 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:62613 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262309AbVCILMz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 06:12:55 -0500
Date: Wed, 9 Mar 2005 12:11:02 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, chrisw@osdl.org,
       torvalds@osdl.org, akpm@osdl.org
Subject: Re: Linux 2.6.11.2
Message-ID: <20050309111102.GA30119@elf.ucw.cz>
References: <20050309083923.GA20461@kroah.com> <Pine.LNX.4.61.0503090950200.7496@student.dei.uc.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0503090950200.7496@student.dei.uc.pt>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On St 09-03-05 09:52:46, Marcos D. Marado Torres wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On Wed, 9 Mar 2005, Greg KH wrote:
> 
> >which is a patch against the 2.6.11.1 release.  If consensus arrives
> >that this patch should be against the 2.6.11 tree, it will be done that
> >way in the future.
> 
> IMHO it sould be against 2.6.11 and not 2.6.11.1, like -rc's that are'nt 
> againt
> the last -rc but against 2.6.x.

You expect people to go through all 2.6.11.1, 2.6.11.2, ... . That
means .11.2 should be relative to .11.1, because otherwise people will
have to revert (ugly). And you want people to track -stable kernels as
fast as possible.

So Greg did it right.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
