Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265271AbUETVYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265271AbUETVYS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 17:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265272AbUETVYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 17:24:18 -0400
Received: from [80.72.36.106] ([80.72.36.106]:38117 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S265271AbUETVYR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 17:24:17 -0400
Date: Thu, 20 May 2004 23:24:09 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: linux-kernel@vger.kernel.org
Subject: PCI errors still in 2.6.6-mm4 but rare
Message-ID: <Pine.LNX.4.58.0405202319100.25121@alpha.polcom.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I reported previously that after upgrading to something around 2.6.6
I started getting strange PCI errors. Somebody replied that in mm it 
should be fixed. But still I can see PCI errors like this:

May 20 23:04:13 polb01 Aieee - PCI error! status 0x008008, PCI status 
0x8290

What does that mean? (= how bad my system is broken and can I loose all my 
data fast?) How can I fix this?


Thanks in advance,


Grzegorz Kulewski

