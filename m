Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267355AbUBSQgG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 11:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267360AbUBSQgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 11:36:06 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:62706 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S267355AbUBSQgD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 11:36:03 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Mark Watts <m.watts@eris.qinetiq.com>
Subject: Re: Strange problem with alsa, emu10k1 and ut2003 on 2.6.3
Date: Thu, 19 Feb 2004 17:42:26 +0100
User-Agent: KMail/1.5.3
References: <1077197950.4034bc7ec9730@imp1-q.free.fr> <200402191404.14212.m.watts@eris.qinetiq.com>
In-Reply-To: <200402191404.14212.m.watts@eris.qinetiq.com>
Cc: j.combes.ml@free.fr, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402191742.26900.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I believe that some some of ALSA updates 2.6.2->2.6.3 broke OSS emulation,
ie. xmms works but eats 90-100% CPU.  I experience it with ens1371 driver.

I think it's the same problem, stay tuned...

On Thursday 19 of February 2004 15:04, Mark Watts wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> > Hello,
> >
> > I have a strange problem with the sound on my PC [1] with the kernel
> > 2.6.3 when I play to unreal tournement 2003. I use the same configuration
> > as the 2.6.1 which work quite well on my computer.
> >
> > When I play to UT2003, sounds are not clean : there is some crackling.
> > Moreover, the music is played two or three time faster than normally. As
> > I haven't got this problem with 2.6.1, I imagine that it can be a problem
> > with the new alsa version.
> >
> > I test to read some mp3 with xmms, it seem to work correctly.
>
> Music in UT2003/4 is in .ogg format.

It doesn't matter.

