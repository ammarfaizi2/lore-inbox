Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290567AbSARAtY>; Thu, 17 Jan 2002 19:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290566AbSARAtP>; Thu, 17 Jan 2002 19:49:15 -0500
Received: from webmail.koenigsnet.RWTH-Aachen.DE ([134.130.53.212]:22401 "EHLO
	atlantis.koenigsnet.rwth-aachen.de") by vger.kernel.org with ESMTP
	id <S290567AbSARAsz>; Thu, 17 Jan 2002 19:48:55 -0500
Message-ID: <003201c19fb9$ee32b030$fd358286@koenigsnet.rwthaachen.de>
From: "Patrick Scharrenberg" <pittipatti@web.de>
To: "Andreas Dilger" <adilger@turbolabs.com>
Cc: <linux-kernel@vger.kernel.org>, <ext2-devel@lists.sourceforge.net>
In-Reply-To: <006701c19f97$5531f520$fd358286@koenigsnet.rwthaachen.de> <20020117141853.I29178@lynx.adilger.int>
Subject: Re: 2.4.17 strange ext2 error
Date: Fri, 18 Jan 2002 01:49:05 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> On Jan 17, 2002  21:40 +0100, Patrick Scharrenberg wrote:
> > yesterday I got a very strange ext2 error on my linux machine..
> > The system has a 5-disk raid-5-software-raid and on top of this there is
one
> > ext2 fs which was clean when mounted 1 week ago..
> >
> > kernel 2.4.17 (since 1 week)
> > before it was 2.4.10
>
> When you say it was "clean when mounted 1 week ago" does this mean that
you
> had run e2fsck on it at that time, or just that it did not report any
> errors when you mounted it?  Sometimes it is possible to have corruption
> in your fs for a while without noticing it if you don't run fsck on it.

I meant that I  had run fsck one week ago, because the filesystem was
corrupt (but this was my fault).
At that same time (but after the fsck) I decided to switch to kernel 2.4.17.
But this shouldn't cause such errors with file-loss...

I don't know if it is save for me to run 2.4.17. For now I switched back to
2.4.10.
Tomorrow I'll start an new backup of the data and then try again the.17.
If the error occurs again, I'll post again.... :-)

..patrick

