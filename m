Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280012AbRLBRLR>; Sun, 2 Dec 2001 12:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281504AbRLBRK5>; Sun, 2 Dec 2001 12:10:57 -0500
Received: from waste.org ([209.173.204.2]:33683 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S280012AbRLBRKs>;
	Sun, 2 Dec 2001 12:10:48 -0500
Date: Sun, 2 Dec 2001 11:10:39 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]
In-Reply-To: <E16AZj7-0003qD-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.40.0112021108280.26270-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Dec 2001, Alan Cox wrote:

> > Please consider the following wipe out candidates as well:
> >
> > 2. proprietary CD-ROM
> > 3. xd.c (ridiculous isn't it?)
> > 4. old ide driver...
>
> I know people using all 3 of those, while bugs in some of the old scsi 8bit
> drivers went unnoticed for a year.

We need a 'prompt for unmaintained drivers' trailing-edge option in the
build process so people will know when something's been orphaned and pick
it up.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

