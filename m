Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264389AbUHQIzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264389AbUHQIzb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 04:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268172AbUHQIzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 04:55:31 -0400
Received: from mail.tactel.se ([195.22.66.197]:45286 "EHLO mail.tactel.se")
	by vger.kernel.org with ESMTP id S264389AbUHQIzU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 04:55:20 -0400
Subject: 2.6.8.1-mm1 hangs on boot with ACPI
From: Pontus Fuchs <pontus.fuchs@tactel.se>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1092732915.3260.21.camel@dhcp-225.mlm.tactel.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 17 Aug 2004 10:55:15 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

After upgrading to 2.6.8.1-mm1 from plain 2.6.8.1 my machine does not
boot anymore. The last message i see is:

ACPI: Processor [CPU0] (supports C1,C2,C3, 8 throttling states)

In plain 2.6.8.1 the next messages would be:

ACPI: Thermal Zone [THRM] (52 C)
Console: switching to colour frame buffer device 175x65
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected SiS 648 chipset

Booting with acpi=off works fine. I have also tried pci=routeirq but it
does not make any difference.

The machine is an Asus L5c laptop.

Please CC me, as I'm not subscribing to this list.

Pontus



