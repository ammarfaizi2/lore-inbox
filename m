Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284254AbRLBRbB>; Sun, 2 Dec 2001 12:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283520AbRLBRav>; Sun, 2 Dec 2001 12:30:51 -0500
Received: from mail008.mail.bellsouth.net ([205.152.58.28]:6575 "EHLO
	imf08bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S281599AbRLBRai>; Sun, 2 Dec 2001 12:30:38 -0500
Message-ID: <3C0A6539.B650C789@mandrakesoft.com>
Date: Sun, 02 Dec 2001 12:30:33 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Oliver Xymoron <oxymoron@waste.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]
In-Reply-To: <Pine.LNX.4.40.0112021108280.26270-100000@waste.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Xymoron wrote:
> 
> On Sun, 2 Dec 2001, Alan Cox wrote:
> 
> > > Please consider the following wipe out candidates as well:
> > >
> > > 2. proprietary CD-ROM
> > > 3. xd.c (ridiculous isn't it?)
> > > 4. old ide driver...
> >
> > I know people using all 3 of those, while bugs in some of the old scsi 8bit
> > drivers went unnoticed for a year.
> 
> We need a 'prompt for unmaintained drivers' trailing-edge option in the
> build process so people will know when something's been orphaned and pick
> it up.

There's already CONFIG_OBSOLETE...

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

