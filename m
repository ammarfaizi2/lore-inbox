Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964798AbWI0IqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbWI0IqI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 04:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbWI0IqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 04:46:08 -0400
Received: from mxsf30.cluster1.charter.net ([209.225.28.230]:16825 "EHLO
	mxsf30.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S1750882AbWI0IqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 04:46:05 -0400
Message-ID: <393855126.1159346763423.JavaMail.root@fepweb13>
Date: Wed, 27 Sep 2006 4:46:03 -0400
From: <genestapp@charter.net>
To: linux-kernel@vger.kernel.org
Subject: SATA: Marvell 88SE6141 kernel support?
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
Sensitivity: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I talked to Gord Peters who asked about this sata chip in June. He said there is a experimental patch for it, but the one he had was an old version. I've been looking all over but could not find it. Also I've checked the newest linux kernel builds and there is no mention of mv_61x support. Does anyone know the status of kernel support for this chip? I'm running 2.6.17 kernel currently but will be upgrading to .18 on Thursday (FC5)

I'm using the Asus P5WD2-E motherboard. I've already used the 4 sata ports on the ICH7 chip and I'm looking to expand my software raid 5 array with a couple more drives (and more later).
For reference, this was the earlier thread from archives:
http://lkml.org/lkml/2006/6/14/259

Thank you for your time,
Gene
