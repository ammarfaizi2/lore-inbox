Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932325AbVIMGI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbVIMGI4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 02:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbVIMGI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 02:08:56 -0400
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:35780 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S932325AbVIMGI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 02:08:56 -0400
Date: Tue, 13 Sep 2005 08:07:32 +0200
From: Voluspa <lista1@telia.com>
To: linux-kernel@vger.kernel.org
Subject: Re: "Read my lips: no more merges" - aka Linux 2.6.14-rc1
Message-Id: <20050913080732.20600966.lista1@telia.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


root:sleipner:/usr/src/testing/linux-2.6.14-rc1# make modules_install
[...]
if [ -r System.map -a -x /sbin/depmod ]; then /sbin/depmod -ae -F
System.map  2. 6.14-rc1; fi
WARNING: /lib/modules/2.6.14-rc1/kernel/drivers/char/agp/amd64-agp.ko
needs unknown symbol end_pfn

Mvh
Mats Johannesson
--
