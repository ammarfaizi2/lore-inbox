Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261926AbRE2A72>; Mon, 28 May 2001 20:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261929AbRE2A7S>; Mon, 28 May 2001 20:59:18 -0400
Received: from vger.timpanogas.org ([207.109.151.240]:10500 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S261926AbRE2A7J>; Mon, 28 May 2001 20:59:09 -0400
Date: Mon, 28 May 2001 18:50:59 -0600
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Yuri Per <yuri@acronis.com>,
        Martin von Loewis <loewis@informatik.hu-berlin.de>,
        linux-kernel@vger.kernel.org, Linux-ntfs@tiger.informatik.hu-berlin.de,
        linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [Linux-ntfs] Re: [Linux-NTFS-Dev] Re: ANN: NTFS new release available (1.1.15)
Message-ID: <20010528185059.A2290@vger.timpanogas.org>
In-Reply-To: <3B11E3F1.1090400@acronis.com> <5.1.0.14.2.20010526011903.00aab050@pop.cus.cam.ac.uk> <5.1.0.14.2.20010526000503.04716ec0@pop.cus.cam.ac.uk> <5.1.0.14.2.20010526011903.00aab050@pop.cus.cam.ac.uk> <5.1.0.14.2.20010527123154.00a96640@pop.cus.cam.ac.uk> <200105271253.OAA22557@pandora.informatik.hu-berlin.de> <3B11E3F1.1090400@acronis.com> <5.1.0.14.2.20010528125630.04729ba0@pop.cus.cam.ac.uk> <3B124DD7.1060908@acronis.com> <5.1.0.14.2.20010528154831.04438280@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <5.1.0.14.2.20010528154831.04438280@pop.cus.cam.ac.uk>; from aia21@cam.ac.uk on Mon, May 28, 2001 at 03:49:28PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2001 at 03:49:28PM +0100, Anton Altaparmakov wrote:
> At 14:08 28/05/2001, Yuri Per wrote:
> >Anton Altaparmakov wrote:
> >
> >>Does anyone know what NTFS version the NT 3.1 / 3.51 volumes had? If I 
> >>know  I can make sure we don't mount such beasts considering we know the 
> >>driver  would fail on them... - I am aware of only one person stil using 
> >>NT 3.51  and he doesn't believe in the NTFS Linux driver any more, so I 
> >>guess we can  just say we support NT 4.0 and above only.
> >
> >NT 3.51 uses exactly the same version of NTFS as NT 4.0 does.
> 
> Ok. Thanks.
> 
> Anyone know about 3.1?
> 
> Anton
> 

It's an HPFS variant.  Try the HPFS driver, and it may work.  The first cut
of NT was with a hacked up HPFS driver from Microsoft OS/2.  NTFS was 
designed internally by David G. and friends.

Jeff

> 
> -- 
>    "Nothing succeeds like success." - Alexandre Dumas
> -- 
> Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
> Linux NTFS Maintainer / WWW: http://sf.net/projects/linux-ntfs/
> ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
