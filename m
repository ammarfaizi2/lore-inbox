Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274796AbRIZCtY>; Tue, 25 Sep 2001 22:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274799AbRIZCtO>; Tue, 25 Sep 2001 22:49:14 -0400
Received: from ppp01.ts2.Gloucester.visi.net ([209.96.247.65]:56308 "EHLO
	blimpo.internal.net") by vger.kernel.org with ESMTP
	id <S274796AbRIZCs5>; Tue, 25 Sep 2001 22:48:57 -0400
Date: Tue, 25 Sep 2001 22:48:42 -0400
From: Ben Collins <bcollins@debian.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>, linux-kernel@vger.kernel.org,
        Kristian Hogsberg <hogsberg@users.sourceforge.net>,
        linux1394-devel@lists.sourceforge.net
Subject: Re: Announce: modutils 2.4.9 is available
Message-ID: <20010925224841.O319@visi.net>
In-Reply-To: <3BB12FA3.96460B90@eyal.emu.id.au> <25245.1001471598@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25245.1001471598@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2001 at 12:33:18PM +1000, Keith Owens wrote:
> On Wed, 26 Sep 2001 11:30:11 +1000, 
> Eyal Lebedinsky <eyal@eyal.emu.id.au> wrote:
> >I just built and installed modutils-2.4.9.
> >depmod: Unexpected value (20) in
> >'/lib/modules/2.4.10/kernel/drivers/ieee1394/sbp2.o' for
> >ieee1394_device_size
> >        It is likely that the kernel structure has changed, if so then
> >        you probably need a new version of modutils to handle this
> >kernel.

Kernel 2.4.9/2.4.10 do not contain the latest changes to the ieee1394
tree. I've been trying to push the patches to Linus, but he is real
busy, so it may take some time. Maybe 2.4.11 :)

-- 
 .----------=======-=-======-=========-----------=====------------=-=-----.
/                   Ben Collins    --    Debian GNU/Linux                  \
`  bcollins@debian.org  --  bcollins@openldap.org  --  bcollins@linux.com  '
 `---=========------=======-------------=-=-----=-===-======-------=--=---'
