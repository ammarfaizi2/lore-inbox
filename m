Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317474AbSFMF5o>; Thu, 13 Jun 2002 01:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317476AbSFMF5n>; Thu, 13 Jun 2002 01:57:43 -0400
Received: from gusi.leathercollection.ph ([202.163.192.10]:15535 "EHLO
	gusi.leathercollection.ph") by vger.kernel.org with ESMTP
	id <S317474AbSFMF5m>; Thu, 13 Jun 2002 01:57:42 -0400
Date: Thu, 13 Jun 2002 13:57:33 +0800 (PHT)
From: Federico Sevilla III <jijo@free.net.ph>
X-X-Sender: jijo@kalabaw
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: BugTraq Mailing List <bugtraq@securityfocus.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: rlimits and non overcommit (was: Very large font size ...)
In-Reply-To: <E17INKZ-0000gV-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.44.0206131352510.3677-100000@kalabaw>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,
(cc BugTraq and LKML)

On Thu, 13 Jun 2002 at 06:39, Alan Cox wrote:
> > check to prevent such large sizes from crashing X and/or the X Font
> > Server, I'm alarmed by (1) the way the X font server allows itself to
> > be crashed like this, and (2) the way the entire Linux kernel seems to
> > have been unable to handle the situation. While having a central
> > company or
>
> So turn on the features to conrol it. Set rlimits on the xfs server and
> enable non overcommit (-ac kernel)

I am using SGI's XFS, and I think they follow Marcelo's kernels for the
2.4 series, at the moment. Are there any plans of getting non overcommit
from your tree into Marcelo's?

TIA. :)

 --> Jijo

-- 
Federico Sevilla III   :  <http://jijo.free.net.ph/>
Network Administrator  :  The Leather Collection, Inc.
GnuPG Key ID           :  0x93B746BE

