Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286373AbSAAXnv>; Tue, 1 Jan 2002 18:43:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286382AbSAAXnl>; Tue, 1 Jan 2002 18:43:41 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:29703 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286373AbSAAXn3>; Tue, 1 Jan 2002 18:43:29 -0500
Subject: Re: Why would a valid DVD show zero files on Linux?
To: gbj@theforce.com.au (Grahame Jordan)
Date: Tue, 1 Jan 2002 23:53:39 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), bryce@obviously.com (Bryce Nesbitt),
        linux-kernel@vger.kernel.org, Lionel.Bouton@free.fr (Lionel Bouton),
        Andries.Brouwer@cwi.nl
In-Reply-To: <1009927797.5016.2.camel@falcon> from "Grahame Jordan" at Jan 02, 2002 10:29:53 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16LYix-0001wN-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is this similar to the VCD problem I have where I can mount the cd and
> read the smaller files but cannot read the mpg file (avseq01.dat)?

Unrelated. The .dat files are not normal ISO9660 files they are indexes into
the VCD data which is physical layer stuff and sorted into tracks audio
style.

> it should be done there.  If it nees to be done in userspace then where
> in userspace does this need to be fixed?  I am willing to help but know
> not where to start.

Xine seems to play my videocd's nicely.

Alan

