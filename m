Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263813AbTCVUvk>; Sat, 22 Mar 2003 15:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263819AbTCVUvk>; Sat, 22 Mar 2003 15:51:40 -0500
Received: from [206.246.248.56] ([206.246.248.56]:3602 "EHLO
	gaspar.dragonspyre.net") by vger.kernel.org with ESMTP
	id <S263813AbTCVUvj>; Sat, 22 Mar 2003 15:51:39 -0500
From: "Sean Gillespie" <dragonbyte@dragonspyre.net>
To: <linux-kernel@vger.kernel.org>
Subject: ACPI Problems on a HP ZE4145
Date: Sat, 22 Mar 2003 16:01:42 -0500
Message-ID: <NHBBKNMMGLNAADPIJANHMEBOCAAA.dragonbyte@dragonspyre.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am unable to get ACPI working on my ZE4145 Laptop (BIOS Rev KA.M1.20).  I
have tried 2.4.18 w/ ACPI patch, 2.4.21 w/ ACPI patch, 2.5.53, 2.5.64, and
2.5.65 and have tried pci=acpi and pci=nobios and get the same error with
each one.  I enabled Debug mode for ACPI and this basically what happens.
ACPI: Subsystem revision <varies with kernel>, ACPI Tables successfully
acquired, Parsing all Control Methods, Table [DSDT] - 724 Objects 51 Devices
222 Methods 17 Regions, Parsing all Control Methods, Table [SSDT] 0 Objects,
0 Devices, 0 Methods, 0 Regions, ACPI Namespace successfully loaded at root
c03c89bc, evxfevnt-0073 [04] acpi_enable : Transition to ACPI mode
successful, evgpe-0262:  GPE Block0 defined as GPE0 to GPE63.  The system
then halts <no oops, no panic> on this line <shown as it appears>
Executing all Device _STA and_INI methods:....
Any help would be greatly appreciated please CC any replies to me.

