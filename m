Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270648AbTHGUc4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 16:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270658AbTHGUc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 16:32:56 -0400
Received: from firewall.mdc-dayton.com ([12.161.103.180]:17823 "EHLO
	firewall.mdc-dayton.com") by vger.kernel.org with ESMTP
	id S270648AbTHGUcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 16:32:50 -0400
From: "Kathy Frazier" <kfrazier@mdc-dayton.com>
To: <arjanv@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [APM]  CPU idle calls causing problem with ASUS P4PE MoBo
Date: Thu, 7 Aug 2003 16:44:39 -0500
Message-ID: <PMEMILJKPKGMMELCJCIGOEAECEAA.kfrazier@mdc-dayton.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
In-Reply-To: <1060285402.24858.0.camel@laptop.fenrus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>dmidecode is an application that comes in the kernel-utils rpm that
>dumps a bunch of BIOS information

Here you go, here's the top part.  If you need anything else, let me know.

Regards,
Kathy Frazier


SMBIOS 2.3 present.
DMI 2.3 present.
56 structures occupying 1482 bytes.
DMI table at 0x000F0040.
Handle 0x0000
	DMI type 0, 20 bytes.
	BIOS Information Block
		Vendor: Award Software, Inc.
		Version: ASUS P4PE ACPI BIOS Revision 1006
		Release: 07/15/2003
		BIOS base: 0xF0000
		ROM size: 448K
		Capabilities:
			Flags: 0x000000007FCBDE80
Handle 0x0001
	DMI type 1, 25 bytes.
	System Information Block
		Vendor: System Manufacturer
		Product: System Name
		Version: System Version
		Serial Number: EVAL
Handle 0x0002
	DMI type 2, 8 bytes.
	Board Information Block
		Vendor: ASUSTeK Computer INC.
		Product: P4PE    
		Version: REV 1.xx
		Serial Number: xxxxxxxxxxx
Handle 0x0003
	DMI type 3, 17 bytes.
	Chassis Information Block
		Vendor: Chassis Manufacture
		Chassis Type: Tower
		Version: Chassis Version
		Serial Number: EVAL
		Asset Tag: Asset-1234567890
Handle 0x0004
	DMI type 4, 32 bytes.
	Processor
		Socket Designation: PGA 478
		Processor Type: Central Processor
		Processor Family: 
		Processor Manufacturer: GenuineIntel
		Processor Version: Intel(R) Pentium(R) 4

