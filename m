Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269505AbUIZKqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269505AbUIZKqF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 06:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269506AbUIZKqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 06:46:05 -0400
Received: from smtp08.web.de ([217.72.192.226]:38794 "EHLO smtp08.web.de")
	by vger.kernel.org with ESMTP id S269505AbUIZKqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 06:46:03 -0400
Message-ID: <41569DE5.4080206@web.de>
Date: Sun, 26 Sep 2004 12:45:57 +0200
From: Michael Thonke <tk-shockwave@web.de>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040921)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: AMD64 and NFORCE3 250GB very slow and USB hungs
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I bought just a new AMD64 system with an NForce 3 based mainboard (MSI 
K8N Neo2 Platinum).
When I use the latest kernel from Andrew (2.6.9-rc2-mm3) on boot it 
sometimes hung on boot and the reset state of system is wrong so a have 
to power of the system until usb will work again..at probing the usb 
devices (OHCI,EHCI). Also the system runs really slow and some tasks 
starts and the system hungs. I also tried staircase patches and 
voluntary-preemption but they also wont help.

Any suggestion or hints how to fix that behavior?

Thanks in advance
