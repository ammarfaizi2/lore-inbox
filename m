Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263422AbTDSR4G (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 13:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263426AbTDSR4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 13:56:06 -0400
Received: from mout2.freenet.de ([194.97.50.155]:52409 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S263422AbTDSR4E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 13:56:04 -0400
From: Andreas Hartmann <andihartmann@freenet.de>
X-Newsgroups: fa.linux.kernel
Subject: [2.4.20] No fullduplex support in xircom_tulip_cb module (PCMCIA): Why?
Date: Sat, 19 Apr 2003 20:13:20 +0200
Organization: privat
Message-ID: <b7s3k0$eh9$1@ID-44327.news.dfncis.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Trace: susi.maya.org 1050776000 14889 192.168.1.3 (19 Apr 2003 18:13:20 GMT)
X-Complaints-To: abuse@fu-berlin.de
User-Agent: KNode/0.7.2
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I'm wondering, why the FD-support in the mentioned Module isn't possible.
With the pcmcia_cs module tulip_cb, the same PCMCIA-card Xircom Cardbus
Ethernet and Modem (CBEM56G) is running fine in full duplex modus. Why
isn't it possible with xircom_tulip_cb too?


Regards,
Andreas Hartmann
