Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263992AbTE3SnW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 14:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263993AbTE3SnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 14:43:22 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:22202 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id S263992AbTE3SnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 14:43:20 -0400
Subject: Hit BUG() in 2.5.70 in mm/slab.c:979
From: celestar@t-online.de (Frank Victor Fischer)
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1054321005.2063.8.camel@darkstar.fischer.homeip.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 30 May 2003 20:56:46 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey people,
I hit a BUG() when testing a 2.5.70 kernel in mm/slab.c, line 979. 
I thought someone might want to know.

System is: 

AMD Thunderbird 1000, 
VIA KT133 chipset
512 MB SDR SDRAM

Other installed hardware:
BT848 video capture device
SB Live! Platinum EMU10k1
Etherexpress Pro 100
Promise UDMA 100 IDE controller, 20265 (no devices connected)
GeForce 2 MX VGA card.

hda: Maxtor 53073U6
hdb: IBM-DCAA-33610
hdc: HL-DT-ST SCE-8480B (CDRW)
hdd: CREATIVEDVD6630E 

Used gcc: 2.95.3 
root file system: ext3

floppy disk :)

I am no member of the list, so for any more information, please contact
me on celestar@t-online.de thanks

Victor

