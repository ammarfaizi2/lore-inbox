Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317850AbSGPOFu>; Tue, 16 Jul 2002 10:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317852AbSGPOFt>; Tue, 16 Jul 2002 10:05:49 -0400
Received: from dsl092-148-080.wdc1.dsl.speakeasy.net ([66.92.148.80]:22450
	"EHLO tyan.doghouse.com") by vger.kernel.org with ESMTP
	id <S317850AbSGPOFq>; Tue, 16 Jul 2002 10:05:46 -0400
Date: Tue, 16 Jul 2002 10:08:31 -0400 (EDT)
From: Maxwell Spangler <maxwax@speakeasy.net>
X-X-Sender: <maxwell@tyan.doghouse.com>
To: SCoTT SMeDLeY <ss@aaoepp.aao.gov.au>
cc: <linux-kernel@vger.kernel.org>, <ss@aao.gov.au>
Subject: Re: Tyan s2466 stability
In-Reply-To: <20020716212336.A393@aaopcss.aao.gov.au>
Message-ID: <Pine.LNX.4.33.0207161000100.2603-100000@tyan.doghouse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jul 2002, SCoTT SMeDLeY wrote:

> Hi all,
> 
> I'm considering investing in a dual-AMD system using Tyan's s2466
> motherboard. I'm interested in hearing how others have found the
> stability of this board using recent 2.4.x kernels.
> 
> I've scanned the archives & there doesn't appear to be any reports
> on problems with this board, so I guess I'm hoping to hear some
> positive reports ...
> 
> I'm also interested in hearing reports about how the board performs
> with with non-ECC (non-registered) RAM as the board has been
> documented to work with such an arrangement. I'm happy to fork
> out for ECC RAM, but is it worth it?
> 
> Please reply to: ss@aao.gov.au

I have a one of these as my primary desktop system.  Configuration is:

Antec Performance Plus 880 (MT + 430W high quality power supply)
Tyan S2466N motherborad
Two AMD Athlon MP 1800+ chips
Corsair PC2100 ECC Registered DIMMs 512M each x 2
Matrox G450 AGP
Adaptec 2940AU SCSI PCI + HP cdr
Ensonic ES1731 PCI audio
onboard 3com networking
Opti PCI USB card
IBM 120GXP
Acer 40X ATAPI cdrom

1) The CPU fans, boxed AMD retail fans, are really loud.

2) The system produces a lot of heat.  It's 100F in the very top of my case 
right now.

3) Performance is very, very good, but... for basic Netscape, xterm, pine, 
etc, this system doesn't feel much different from my dual P2-400 system.

4) mp3 encoding is _really_ fast :)

5) This system has been completely stable for me, no crashes or surprise 
lockups.

6) I have only one issue yet to be resolved: SCSI "loss of streaming" errors 
when trying to burn cd-rs.  I haven't taken the time to figure out what the 
problem is there but the fact that others aren't reporting it suggests 
configuration or something else specific to my system and not indicative of 
the MPX chipset or dual Athlon setup, etc.

7) I like the fact that Alan is using the same chipset as me for his 
development :)

8) My RAM, PC2100 ECC registered was $215 or so from crucial.com, and is now 
about $150.  It's worth it to buy quality RAM and not have to worry about 
whether your system problems are being caused buy RAM.. Completely worth it.

I'm very happy with dual Athlon and would recommend them to others.

-- ----------------------------------------------------------------------------
Maxwell Spangler                                                
Program Writer                                              
Greenbelt, Maryland, U.S.A.                         
Washington D.C. Metropolitan Area 

