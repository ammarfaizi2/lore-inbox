Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265840AbTL3QsR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 11:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265843AbTL3QsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 11:48:17 -0500
Received: from ext1.srdnet.com ([63.170.161.100]:27589 "EHLO
	lnxext1.srdnet.extra") by vger.kernel.org with ESMTP
	id S265840AbTL3QsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 11:48:14 -0500
Message-ID: <3FF1AC4D.9040002@macykids.net>
Date: Tue, 30 Dec 2003 08:48:13 -0800
From: Brian Macy <bmacy@macykids.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.0 and Starfire NIC
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus: Scanned by F-Prot Antivirus (http://www.f-prot.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When switching to 2.6.0 my Starfire NIC fails to function with an 
entertaining message:
Dec 23 16:36:45 job kernel: eth0: Something Wicked happened! 0x02018101.
Dec 23 16:36:45 job kernel: eth0: Something Wicked happened! 0x02010001.

I don't know if this is related but in 2.4 I get PCI bus congestion for 
the starfire adapter:
eth0: PCI bus congestion, increasing Tx FIFO threshold to 80 bytes
eth0: PCI bus congestion, increasing Tx FIFO threshold to 96 bytes
eth0: PCI bus congestion, increasing Tx FIFO threshold to 112 bytes
eth0: PCI bus congestion, increasing Tx FIFO threshold to 128 bytes
eth0: PCI bus congestion, increasing Tx FIFO threshold to 144 bytes
eth0: PCI bus congestion, increasing Tx FIFO threshold to 160 bytes


Brian Macy

