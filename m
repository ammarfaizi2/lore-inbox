Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbWFAJ2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbWFAJ2x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 05:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbWFAJ2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 05:28:52 -0400
Received: from smtp1.kolej.mff.cuni.cz ([195.113.24.4]:36365 "EHLO
	smtp1.kolej.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1750839AbWFAJ2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 05:28:52 -0400
X-Envelope-From: zajio1am@artax.karlin.mff.cuni.cz
Date: Thu, 1 Jun 2006 11:28:07 +0200
From: Ondrej Zajicek <santiago@mail.cz>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: "D. Hazelton" <dhazelton@enter.net>, Dave Airlie <airlied@gmail.com>,
       Pavel Machek <pavel@ucw.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org, adaplas@gmail.com
Subject: Re: OpenGL-based framebuffer concepts
Message-ID: <20060601092807.GA7111@localhost.localdomain>
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <200605302314.25957.dhazelton@enter.net> <9e4733910605302116s5a47f5a3kf0f941980ff17e8@mail.gmail.com> <200605310026.01610.dhazelton@enter.net> <9e4733910605302139t4f10766ap86f78e50ee62f102@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910605302139t4f10766ap86f78e50ee62f102@mail.gmail.com>
X-Operating-System: Debian GNU/Linux 3.1 (Sarge)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2006 at 12:39:19AM -0400, Jon Smirl wrote:
> >Yes, but I have accepted that there is a certain direction and order the
> >maintainers want things done in. For this reason I can't just leave DRM
> >alone.
> 
> fbdev (Antonino A. Daplas <adaplas@gmail.com>) and DRM (Dave Airlie
> <airlied@gmail.com>) have two different maintainers. I have not seen
> Tony comment on what he thinks of Dave's plans so I don't know what
> his position is how driver merging can be acomplished.

Is there some document describing long-term direction or plans for this?
(another than http://jonsmirl.googlepages.com/graphics.html)
I googled for last Kernel Summit mentioned here but didn't found anything
specific.

-- 
Elen sila lumenn' omentielvo

Ondrej 'SanTiago' Zajicek (email: santiago@mail.cz, jabber: santiago@njs.netlab.cz)
OpenPGP encrypted e-mails preferred (KeyID 0x11DEADC3, wwwkeys.pgp.net)
"To err is human -- to blame it on a computer is even more so."
