Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261491AbULFKxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbULFKxQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 05:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbULFKxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 05:53:16 -0500
Received: from math.ut.ee ([193.40.5.125]:59072 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S261491AbULFKxN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 05:53:13 -0500
Date: Mon, 6 Dec 2004 12:53:11 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: ACPI PnP errors
Message-ID: <Pine.SOC.4.61.0412061251570.25485@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the same Toshiba Satellite 1800-314 laptop that I debugged 
smsc-ircc2 pnp activation on. This time it's plain 2.6.10-rc3 and it 
gives theses errors in dmesg but seems to work:

pnp: PnP ACPI init
acpi_bus-0081 [03] acpi_bus_get_device   : Error getting context for object [cefcba48]
acpi_bus-0081 [03] acpi_bus_get_device   : Error getting context for object [cefcb888]
acpi_bus-0081 [03] acpi_bus_get_device   : Error getting context for object [cefcb608]
acpi_bus-0081 [03] acpi_bus_get_device   : Error getting context for object [cefcb548]
acpi_bus-0081 [03] acpi_bus_get_device   : Error getting context for object [cefcb488]
pnp: PnP ACPI: found 13 devices

-- 
Meelis Roos (mroos@linux.ee)
