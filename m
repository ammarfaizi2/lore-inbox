Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275166AbRIZMwb>; Wed, 26 Sep 2001 08:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275167AbRIZMwW>; Wed, 26 Sep 2001 08:52:22 -0400
Received: from MAILGW01.bang-olufsen.dk ([193.89.221.116]:47368 "EHLO
	mailgw01.bang-olufsen.dk") by vger.kernel.org with ESMTP
	id <S275166AbRIZMwP>; Wed, 26 Sep 2001 08:52:15 -0400
To: Ben Collins <bcollins@debian.org>
Cc: Keith Owens <kaos@ocs.com.au>, Eyal Lebedinsky <eyal@eyal.emu.id.au>,
        linux-kernel@vger.kernel.org,
        Kristian Hogsberg <hogsberg@users.sourceforge.net>,
        linux1394-devel@lists.sourceforge.net
Subject: Re: Announce: modutils 2.4.9 is available
In-Reply-To: <3BB12FA3.96460B90@eyal.emu.id.au>
	<25245.1001471598@kao2.melbourne.sgi.com>
	<20010925224841.O319@visi.net>
From: Kristian Hogsberg <hogsberg@users.sourceforge.net>
Date: 26 Sep 2001 14:52:32 +0200
In-Reply-To: <20010925224841.O319@visi.net>
Message-ID: <m3ite62jxr.fsf@dk20037170.bang-olufsen.dk>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on BeoSmtp/Bang & Olufsen/DK(Release 5.0.6a |January
 17, 2001) at 26-09-2001 14:52:36,
	Serialize by Router on dzln11/Bang & Olufsen/DK(Release 5.0.6 |December 14, 2000) at
 26-09-2001 14:52:42,
	Serialize complete at 26-09-2001 14:52:42
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Collins <bcollins@debian.org> writes:

> On Wed, Sep 26, 2001 at 12:33:18PM +1000, Keith Owens wrote:
> > On Wed, 26 Sep 2001 11:30:11 +1000, 
> > Eyal Lebedinsky <eyal@eyal.emu.id.au> wrote:
> > >I just built and installed modutils-2.4.9.
> > >depmod: Unexpected value (20) in
> > >'/lib/modules/2.4.10/kernel/drivers/ieee1394/sbp2.o' for
> > >ieee1394_device_size
> > >        It is likely that the kernel structure has changed, if so then
> > >        you probably need a new version of modutils to handle this
> > >kernel.
> 
> Kernel 2.4.9/2.4.10 do not contain the latest changes to the ieee1394
> tree. I've been trying to push the patches to Linus, but he is real
> busy, so it may take some time. Maybe 2.4.11 :)

Yes, when I sent the patch to modutils, I expected the latest cvs
changes to make it into 2.4.10.  Hopefully they will be in 2.4.11.

Kristian


