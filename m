Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262930AbUECEX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262930AbUECEX0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 00:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263584AbUECEX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 00:23:26 -0400
Received: from relay01.kbs.net.au ([203.220.32.149]:11221 "EHLO
	relay01.kbs.net.au") by vger.kernel.org with ESMTP id S262930AbUECEXZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 00:23:25 -0400
Message-ID: <090701c430c6$5fad3060$cf01a8c0@internal.kbs.net.au>
From: "Paul" <paul@kbs.net.au>
To: <linux-kernel@vger.kernel.org>
Subject: sata_sil and lost interrupt
Date: Mon, 3 May 2004 14:23:21 +1000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi everyone,

im trying to get an adaptec 1210SA card working. I keep seeing "lost
interrupts". I'm trying to find a patch to correct it. I've tried 2.4.27
with libata patch and also 2.6.4 but both still have the same problem. I was
recently emailed an updated sata_sil.c from someone on this list to correct
the issues but I've since lost the file and email due to a hard disk crash.
Does anyone have a known working patch to correct the lost interrupt issues
with the sata_sil driver?

Thanks

