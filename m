Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130668AbRBLTP3>; Mon, 12 Feb 2001 14:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130778AbRBLTPS>; Mon, 12 Feb 2001 14:15:18 -0500
Received: from romulus.cs.ut.ee ([193.40.5.125]:407 "EHLO romulus.cs.ut.ee")
	by vger.kernel.org with ESMTP id <S130668AbRBLTPJ>;
	Mon, 12 Feb 2001 14:15:09 -0500
Date: Mon, 12 Feb 2001 21:14:17 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: <linux-kernel@vger.kernel.org>
Subject: ACPI idle
Message-ID: <Pine.GSO.4.32.0102122111310.10120-100000@romulus.cs.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tried 2.4.1-ac10 (this includes 2.4.2-pre3 so the latest ACPI updates ar
in). Acpi-idle slowdown is still there, acpi=no-idle helps. Via KT133
chipset, Soltek 75KV motherboard, Duron 600.

ACPI info from dmesg:

ACPI: Core Subsystem version [20010208]
ACPI: Subsystem enabled
ACPI: System firmware supports: C2 C3
ACPI: plvl2lat=90 plvl3lat=900
ACPI: C2 enter=1288 C2 exit=322
ACPI: C3 enter=38653 C3 exit=3221
ACPI: Not using ACPI idle
ACPI: System firmware supports: S0 S1 S5

---
Meelis Roos <mroos@linux.ee>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
