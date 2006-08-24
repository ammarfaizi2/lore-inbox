Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030447AbWHXSjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030447AbWHXSjh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 14:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030446AbWHXSjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 14:39:37 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:20944 "EHLO
	fmmailgate03.web.de") by vger.kernel.org with ESMTP
	id S1030454AbWHXSjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 14:39:36 -0400
Message-ID: <014301c6c7ad$a84b88f0$962e8d52@aldipc>
From: "roland" <devzero@web.de>
To: <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE][RFC] kvblade-alpha-2 / ATA Over Ethernet kernel "target" module
Date: Thu, 24 Aug 2006 20:46:43 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello !

If you don`t know about AoE and being interested in network-based
Storage/SAN technology, you may take a look at
http://www.linuxjournal.com/article/8149 first. This article gives a nice
introduction into AoE technology.

Kvblade is the kernel-based equivalent of (userspace)vblade and also a
second approach (there is another at http://lpk.com.price.ru/~lelik/AoE/) to
build an kernel-based AoE "target" (a vblade in AoE terminology is similar
to iscsi-target or nbd-server, exporting a block-device over the network,
but working on ethernet-layer instead of TCP/IP)

Kvblade is counterpart to the AoE driver which is in 2.6 for some time now
and it basically does in software, what "Coraid EtherDrive® Storage" does in
hardware.

Kvblade is now part of the aoetools project at
http://aoetools.sourceforge.net . It`s at an early alpha stage and the
initial creator, Sam Hopkins from Coraid just decided to release it to the
public due to lack of time working further on this.

Unfortunately i`m no kernel hacker, but maybe there is someone who likes to
give it a try, make a little code-review, pick it up and contribute or even
rewrite it from scratch. :)

regards
Roland Kletzing
(sysadmin/engineer, independent linux enthusiast, not related to Coraid)

