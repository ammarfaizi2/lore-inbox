Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261537AbVCIKFk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbVCIKFk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 05:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262232AbVCIKFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 05:05:39 -0500
Received: from witte.sonytel.be ([80.88.33.193]:24316 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261537AbVCIKFe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 05:05:34 -0500
Date: Wed, 9 Mar 2005 11:04:57 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
cc: Greg KH <greg@kroah.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       chrisw@osdl.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Linux 2.6.11.2
In-Reply-To: <Pine.LNX.4.61.0503090950200.7496@student.dei.uc.pt>
Message-ID: <Pine.LNX.4.62.0503091104180.22598@numbat.sonytel.be>
References: <20050309083923.GA20461@kroah.com> <Pine.LNX.4.61.0503090950200.7496@student.dei.uc.pt>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Mar 2005, Marcos D. Marado Torres wrote:
> On Wed, 9 Mar 2005, Greg KH wrote:
> > which is a patch against the 2.6.11.1 release.  If consensus arrives
> > that this patch should be against the 2.6.11 tree, it will be done that
> > way in the future.
> 
> IMHO it sould be against 2.6.11 and not 2.6.11.1, like -rc's that are'nt
> againt
> the last -rc but against 2.6.x.

It's a stable release, not a pre/rc, so against 2.6.11.1 sounds most logical to
me.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
