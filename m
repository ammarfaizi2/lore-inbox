Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284285AbRLXBMx>; Sun, 23 Dec 2001 20:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284300AbRLXBMe>; Sun, 23 Dec 2001 20:12:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:64295 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S284285AbRLXBM0>;
	Sun, 23 Dec 2001 20:12:26 -0500
Date: Mon, 24 Dec 2001 02:12:17 +0100
From: Christian Ohm <chr.ohm@gmx.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: file corruption in 2.4.16/17
Message-ID: <20011224011216.GC1482@moongate.thevoid.net>
In-Reply-To: <Pine.LNX.4.10.10112222218220.8976-100000@master.linux-ide.org> <E16I8qJ-0000bm-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16I8qJ-0000bm-00@the-village.bc.nu>
User-Agent: Mutt/1.3.24i
Organization: theVoid
X-Operating-System: Linux moongate 2.4.17 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't think its remotely related to the IDE layer
> 
> A number of VIA boards have hardware/bios problems that cause corruption
> under certain very high PCI loads. Current 2.4 should set the registers
> to do the work arounds needed on the various boards we know have the 
> problems as do the VIA 4in1 drivers for windows in most afflicted cases.
> 
> The description sounds extremely like that is the problem with this board.

hmmm, could be... i had a problem with ide before... i connected an old 4x
cdrom drive, and when accessing it, the sound slowed down (soundblaster
awe64 pnp, alsa driver). and most corruption could be caused during a high
pci load, so this could be a hardware problem. anything you might want to
know aboiut the board?

bye
christian ohm
