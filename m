Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264429AbTE1CHW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 22:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264478AbTE1CHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 22:07:22 -0400
Received: from kaneda.boo.net ([216.200.67.189]:46474 "EHLO kaneda.boo.net")
	by vger.kernel.org with ESMTP id S264429AbTE1CHV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 22:07:21 -0400
Message-Id: <5.2.1.1.2.20030527222151.00a4e670@boo.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Tue, 27 May 2003 22:25:51 -0400
To: linux-kernel@vger.kernel.org
From: Jason Papadopoulos <jasonp@boo.net>
Subject: Re: Linux 2.4.21-rc5
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 > Mainly due to a IDE DMA problem which would happen on boxes with lots of
 > RAM, here is -rc5.

Neither -rc5, nor a patch by Ivan, nor both, can get UDMA to turn on
automatically at boot time on my machine. This is a 466MHz DS10 Alphaserver,
2GB RAM, ALI 1543 IDE controller that is capable of UDMA2. hdparm can turn
on multiword DMA but not UDMA.

Hope this helps,
jasonp

