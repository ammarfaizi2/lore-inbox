Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273691AbRIQUVn>; Mon, 17 Sep 2001 16:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273692AbRIQUVd>; Mon, 17 Sep 2001 16:21:33 -0400
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:40905 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S273691AbRIQUVT>; Mon, 17 Sep 2001 16:21:19 -0400
Message-ID: <8FB7D6BCE8A2D511B88C00508B68C208197175@orsmsx102.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'SirVer@gmx.de'" <SirVer@gmx.de>, linux-kernel@vger.kernel.org
Subject: RE: ACPI and SCSI.
Date: Mon, 17 Sep 2001 13:20:38 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Have you tried it with just the base ACPI support (no processor)?

Please send me your dmesg output and /proc/interrupts, too.

Regards -- Andy

> From: SirVer@gmx.de [mailto:SirVer@gmx.de]
> just a short question (probably a still unknown bug, I didn't find
> anything about this): 
>  My Box: a AdvanSys SCSI Low Cost Controller
>          a TEAC CDR 55S CD-Burner connected to it
> 			a new motherboard (Asus) with ACPI, 
> without APM support
> 
> now, when i enable ACPI Processor support (nothing else) and i try to
> mount a CD, the computer crashes sometimes, but if it doesn't crash on
> mounting, it crashes later while accessing the CD. The Display goes
> black and the computer doesn't make a move anymore. The software power
> switch doesn't work any longer. 
> I guess, that this is a bug in the kernel, for the CD works when i
> disable the ACPI support and for i never had any problems under *BSD.
> But I wasn't able to track the problem down in the source. 
> Anyone any ideas?
