Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263952AbTGTO6X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 10:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266807AbTGTO6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 10:58:23 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:28358 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S263952AbTGTO6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 10:58:22 -0400
Subject: More ACPI funnies in 2.6.0test1
From: "Trever L. Adams" <tadams-lists@myrealbox.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1058714000.2488.2.camel@aurora.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 20 Jul 2003 11:13:20 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alright, same board here, Asus A7N8X-Deluxe (nVidia nForce 2).  I have
pci=noacpi.  However, if I leave ACPI on, I get two funnies:

1) My disk seems to be more active, I hear it clicking much more
2) When eth0 gets shutdown on power off, it freezes.  However, I just
tried to force it by manually shutting it off and it works fine.

I will provide the sysrq output later today when I will have more paper
around to write down the output.

This box works fine with pci=noacpi and acpi=off.  So, I am just trying
to figure out how to get it to work fine with the power stuff working,
even if the irq related part is broken.  It would be nice to fix it all
actually.

Trever
--
"It was as true as taxes is. And nothing's truer than them." -- Charles
Dickens (1812-70)

