Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261606AbVC0W1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbVC0W1w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 17:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbVC0W1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 17:27:51 -0500
Received: from bay104-f21.bay104.hotmail.com ([65.54.175.31]:24311 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261606AbVC0W1o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 17:27:44 -0500
Message-ID: <BAY104-F21CE6F100043D58186803FDF430@phx.gbl>
X-Originating-IP: [65.54.175.202]
X-Originating-Email: [paveraware@hotmail.com]
From: "Christensen Tom" <paveraware@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Network Performance Ingo's RT-Preempt
Date: Sun, 27 Mar 2005 22:27:40 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 27 Mar 2005 22:27:41.0892 (UTC) FILETIME=[30B0C840:01C5331C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running 2.6.11 with Ingo's Preempt patch 
(realtime-preempt-2.6.11-final-V0.7.40-04).  The system is SMP with a 
broadcom NIC (tg3 driver).  I am seeing truly appalling network performance 
(2-4kbps on a 1gbps network).  Is this a known issue?  I know this patch is 
not production ready, what traces/logs do you need/want to be able to 
debug/fix this?
Thanks,
Tom


