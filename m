Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263375AbTKFG1H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 01:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263378AbTKFG1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 01:27:07 -0500
Received: from boo-mda02.boo.net ([216.200.67.22]:14568 "EHLO kaneda.boo.net")
	by vger.kernel.org with ESMTP id S263375AbTKFG1G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 01:27:06 -0500
Message-Id: <5.2.1.1.2.20031106012936.00a9b030@boo.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Thu, 06 Nov 2003 01:34:35 -0500
To: linux-kernel@vger.kernel.org
From: Jason Papadopoulos <jasonp@boo.net>
Subject: Alpha: ALi 15x3 DMA completely broken now
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello. 2.4.21-rc could not start DMA at boot time on
my system, but hdparm could turn it on afterwards. Now
with 2.4.22, nothing will turn on DMA; using hdparm
locks the machine immediately.

The machine in question is an DS10 Alphaserver, Ali
M5229 rev c0 IDE controller. Has 2.4.23-pre made any
fixes for this device?

Thanks in advance,
jasonp

