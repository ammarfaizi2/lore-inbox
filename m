Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262380AbUDKQSa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Apr 2004 12:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262391AbUDKQSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Apr 2004 12:18:30 -0400
Received: from paris.monnet.biz ([81.57.102.142]:41614 "EHLO
	turbigo-2-81-57-102-142.fbx.proxad.net") by vger.kernel.org with ESMTP
	id S262380AbUDKQS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Apr 2004 12:18:29 -0400
Subject: Disabling IRQ, no one cared, Sil 3112 on nForce 2
From: NM Lists <mlists@paris.monnet.biz>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1081700338.10793.2.camel@paris.monnet.biz>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 11 Apr 2004 18:18:58 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I see there is still no resolution on this problem. I tried 2.6.5,
did'nt work, noapic doesn't do shit either. Upgrading Abit Bios to
latest (an7_15) did'nt do anything.

However I found the following: the bug only triggers when I'm using both
SATA channels. With two drives, but only one connected, no problem seems
to occur.

HTH

