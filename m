Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282872AbRLGQ2n>; Fri, 7 Dec 2001 11:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282874AbRLGQ2W>; Fri, 7 Dec 2001 11:28:22 -0500
Received: from air-1.osdl.org ([65.201.151.5]:54021 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S282873AbRLGQ2P>;
	Fri, 7 Dec 2001 11:28:15 -0500
Date: Fri, 7 Dec 2001 08:24:06 -0800 (PST)
From: <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Cory Bell <cory.bell@usa.net>
cc: <john@deater.net>, <linux-kernel@vger.kernel.org>
Subject: Re: IRQ Routing Problem on ALi Chipset Laptop (HP Pavilion N5425)
In-Reply-To: <1007688442.6675.8.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.33L2.0112070822090.25484-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 Dec 2001, Cory Bell wrote:

| On Thu, 2001-12-06 at 17:03, Randy.Dunlap wrote:
| > Hi-
| >
| > Did your search for "$PIR" or "RIP$" ?
| > It is suppsed to be the latter (little-endian).
|
| Tried both. The flash BIOS update might be reading system specific stuff
| and then appending it to the new update, though. Maybe they have
| separate "code" and data areas, and the the data part never gets
| overwritten.
|
| Would you happen to have any thoughts or advice WRT the problem we have
| and the proper method of addressing it? Absent a BIOS fix, of course,
| which I imagine would be the ultimate solution.

Nothing specific, sorry.

Get SiS, ALI, VIA, and ServerWorks to publish their specs.  :)

Good luck.
-- 
~Randy

