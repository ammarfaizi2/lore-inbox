Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbTLOCKa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 21:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263007AbTLOCKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 21:10:30 -0500
Received: from [202.37.96.11] ([202.37.96.11]:30912 "EHLO
	gatekeeper.tait.co.nz") by vger.kernel.org with ESMTP
	id S262960AbTLOCK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 21:10:29 -0500
Date: Mon, 15 Dec 2003 15:11:22 +1300
From: Dmytro Bablinyuk <dmytro.bablinyuk@tait.co.nz>
Subject: How to send an IP packet from the kernel
To: linux-kernel@vger.kernel.org
Message-id: <3FDD184A.80203@tait.co.nz>
Organization: Tait Electronics Ltd
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a dstaddr, srcaddr and the actual data(payload). I need to load 
IP packet with data(payload) and send the packet out to the net through 
eth0 .
How do I do this from the kernel?

Thank you

