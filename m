Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750955AbVIFVMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbVIFVMt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 17:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbVIFVMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 17:12:49 -0400
Received: from mailgw.aecom.yu.edu ([129.98.1.16]:13292 "EHLO
	mailgw.aecom.yu.edu") by vger.kernel.org with ESMTP
	id S1750952AbVIFVMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 17:12:48 -0400
Mime-Version: 1.0
Message-Id: <a06230908bf43b486d98f@[129.98.90.227]>
Date: Tue, 6 Sep 2005 17:13:15 -0400
To: drbd-user@linbit.com, linux-kernel@vger.kernel.org
From: Maurice Volaski <mvolaski@aecom.yu.edu>
Subject: Kernel 2.6.13 is hiding devices from /dev [Was Why is the kernel
 hiding drbd devices?}
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel module drbd (version 0.7.13) can no longer find its 
devices (e.g., /dev/drbd0, /dev/drbd1) in kernel 2.6.13. The version 
of udev I am using 065/068 didn't make a difference. It works fine 
with kernel 2.6.12.5 and 2.6.12.6.
-- 

Maurice Volaski, mvolaski@aecom.yu.edu
Computing Support, Rose F. Kennedy Center
Albert Einstein College of Medicine of Yeshiva University
