Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261792AbUCPW77 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 17:59:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbUCPW77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 17:59:59 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:34216 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S261792AbUCPW76 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 17:59:58 -0500
Message-ID: <405786EC.5000803@matchmail.com>
Date: Tue, 16 Mar 2004 14:59:56 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040304)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Status HPT374 (HighPoint 1540) Sata in 2.6
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The low end of the market is dominated by the SII3112 chipset, so I'm 
looking for an alternative 4-port JBOD SATA controller and came across 
the High Point card.

How is the support of these cards from libata and/or drivers/ide in 2.6?

Alternatively, are there any 4-port (alternatively I can use two 2-port 
SATA controllers) JBOD SATA PCI cards with good support in the 2.6 
kernel (or with patches) in the ~$50 US price range?

Mike
