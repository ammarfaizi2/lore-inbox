Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262002AbTICMTU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 08:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262010AbTICMTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 08:19:20 -0400
Received: from smtp02.web.de ([217.72.192.151]:27671 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S262002AbTICMTT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 08:19:19 -0400
From: "Mehmet Ceyran" <mceyran@web.de>
To: <linux-kernel@vger.kernel.org>
Subject: Who maintains drivers/sound/i810_audio.c?
Date: Wed, 3 Sep 2003 14:22:07 +0200
Message-ID: <001f01c37215$fe6bc060$0100a8c0@server1>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
Importance: Normal
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I found and fixed a little bug in the "Intel ICH (i8xx), SiS 7012,
NVidia nForce Audio or AMD 768/811x" driver (kernel 2.4.23-pre2) that
occured on my laptop with SiS 7012 onBoard sound and wanted to
contribute it to the official kernel sources.

In the maintainers file that came with the kernel I couldn't find the
maintainer of that particular driver so I'd appreciate if someone lead
me to the correct mailing list so I can post the bug and my patch to the
right place.

I wrote to linux-sound@vger.kernel.org yesterday but got no answer yet.

Best regards,
Mehmet Ceyran

