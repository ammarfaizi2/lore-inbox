Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261320AbVBNAZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbVBNAZi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 19:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbVBNAZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 19:25:38 -0500
Received: from smtpout3.compass.net.nz ([203.97.97.135]:13999 "EHLO
	smtpout1.compass.net.nz") by vger.kernel.org with ESMTP
	id S261320AbVBNAZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 19:25:33 -0500
Date: Mon, 14 Feb 2005 13:24:59 +1300 (NZDT)
From: steve@perfectpc.co.nz
X-X-Sender: sk@kieu
Reply-To: steve@perfectpc.co.nz
To: linux-kernel@vger.kernel.org
Subject: 2.6.10 parport_pc: Ignoring new-style parameters in presence of
 obsolete ones
Message-ID: <Pine.LNX.4.60.0502141322120.2596@kieu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

When I run

modprobe parport_pc io=0x378 irq=7

and found 
parport_pc: Ignoring new-style parameters in presence of obsolete ones
in dmesg output and of course my paralel port does not use irq.

Have no way to tell parport_pc to use IRQ? With 2.6.8 the above command is fine.
Search the parport.txt in the Documentation dir and found nothing changes.

Please help me to set IRQ for my parport. Thanks.


Steve Kieu
PerfectPC Ltd. Technical Division.
Web: http://www.perfectpc.co.nz/
