Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267983AbRG2NsI>; Sun, 29 Jul 2001 09:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267976AbRG2Nr6>; Sun, 29 Jul 2001 09:47:58 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:30985 "EHLO
	mailout04.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S267983AbRG2Nrj>; Sun, 29 Jul 2001 09:47:39 -0400
Date: 29 Jul 2001 10:22:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
cc: alan@lxorguk.ukuu.org.uk
Message-ID: <85mYuz3mw-B@khms.westfalen.de>
In-Reply-To: <87g0bg7ded.fsf@pfaffben.user.msu.edu>
Subject: Re: make rpm
X-Mailer: CrossPoint v3.12d.kh7 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <E15QeJf-0008O8-00@the-village.bc.nu> <87g0bg7ded.fsf@pfaffben.user.msu.edu>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

pfaffben@msu.edu (Ben Pfaff)  wrote on 28.07.01 in <87g0bg7ded.fsf@pfaffben.user.msu.edu>:

> Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
>
> > I've been meaning to do this one for a while and I now have it working so
> > that with my current -ac kernel working tree I can type
> >
> > 	make rpm
> >
> > and out puts kernel-2.4.7ac3-1.i386.rpm
> >
> > All this took was the pieces below.
> >
> > Anyone care to knock up a "make dpkg" to go with it ?
>
> Debian has had a package that does this for years now.  It's
> called `kernel-package' and works through a program called
> `make-kpkg' that does all sorts of nice things.  Using
> kernel-package, you could implement `make dpkg' as a single
> command: `make-kpkg kernel_image'.

Well, kernel-package certainly could do with more publicity. There are  
still many Debian users who don't know about it.

MfG Kai
