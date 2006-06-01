Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751026AbWFAOw1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbWFAOw1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 10:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbWFAOw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 10:52:27 -0400
Received: from wx-out-0102.google.com ([66.249.82.192]:65441 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751018AbWFAOw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 10:52:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=MN/mWYPCdccwBUB8hh+8o9unn0xLGIDvbdyFzB2Z2z4YjT3Jq35FcluAIMf6CNuYsE2ohDVVPK38apD7U5DfxC8ZlgMc6OnkOUgWPSbZlL5rlcNzznHET3kDK5aWaQOM/SoBaS+UxqsZS4CoTJGI0zQkd62MfBIKgQjfgiirblo=
Message-ID: <a44ae5cd0606010752n637c6411l805115f8170f0ebb@mail.gmail.com>
Date: Thu, 1 Jun 2006 10:52:26 -0400
From: "Miles Lane" <miles.lane@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>
Subject: 2.6.17-rc5-mm2 -- PCI: Bus #03 (-#06) is hidden behind transparent bridge #02 (-#02) (try 'pci=assign-busses')
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI: setting ELCR to 0200 (from 0c38)
PM: Adding info for No Bus:platform
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd9c2, last bus=2
Setting up standard PCI resources
ACPI: Subsystem revision 20060310
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
PM: Adding info for acpi:acpi
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PM: Adding info for No Bus:pci0000:00
Boot video device is 0000:00:02.0
PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 1180-11bf claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
PCI: Bus #03 (-#06) is hidden behind transparent bridge #02 (-#02)
(try 'pci=assign-busses')
Please report the result to linux-kernel to fix this permanently
