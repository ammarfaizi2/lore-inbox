Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261893AbTCaXMe>; Mon, 31 Mar 2003 18:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261895AbTCaXMe>; Mon, 31 Mar 2003 18:12:34 -0500
Received: from grunt4.ihug.co.nz ([203.109.254.44]:3303 "EHLO
	grunt4.ihug.co.nz") by vger.kernel.org with ESMTP
	id <S261893AbTCaXMd>; Mon, 31 Mar 2003 18:12:33 -0500
Date: Tue, 1 Apr 2003 11:23:49 +1200 (NZST)
From: jmduthie@ihug.co.nz
X-X-Sender: spudgun@hades.internal.beyondhelp.co.nz
Reply-To: john@beyondhelp.co.nz
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: John M Collins <jmc@xisl.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Query about SIS963 Bridges
In-Reply-To: <1048467041.10727.100.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0303300940200.16280-100000@hades.internal.beyondhelp.co.nz>
X-I-Opt-Out-NOW: E-Mail Addresses in this message may not be used to Deliver Unsolicited Commercial E-mail - This E-Mail message is NOT a request to subscribe to any E-mail advertising service or list
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Mar 2003, Alan Cox wrote:

-> Date: 24 Mar 2003 00:50:41 +0000
-> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
-> To: John M Collins <jmc@xisl.com>
-> Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
-> Subject: Re: Query about SIS963 Bridges
->
-> On Sun, 2003-03-23 at 23:31, John M Collins wrote:
-> > I've just got a new machine (2.5 GHz pentium lots of RAM and disk space)
-> > which has one of these SIS963 Southbridge creatures and I get the
-> > message on booting a 2.4.19ish sort of kernel.
->
-> The SiS963 is currently a winputer.

Nooooooooo!
Arrgh !
darn
no wonder my setup is broken after that H/W upgrade

2.2.20 actually works with my PCI NIC (no support for my paradise ATA)
2.4.x does not work with nic or (00:0b.0 Unknown mass storage controller:
                                 Promise Technology, Inc.: Unknown device
                                 4d68 (rev 01) )
2.4.20 slackware 9.0 bare.i works with the PCI NIC and PCI ATA card (no
acpi in this kernel)

is ACPI the problem with this chipset ?

I'd like to get this board working is there any information I can provide that would give
you another data point ....

Just tell me which kernel/patch and what info you need..


--
John Duthie
E-Mail:   <jmduthie@ihug.co.nz>
 When you choke a smurf, what color does it turn?





