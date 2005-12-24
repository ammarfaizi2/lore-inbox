Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751241AbVLXPUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbVLXPUt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 10:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbVLXPUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 10:20:49 -0500
Received: from rwcrmhc14.comcast.net ([216.148.227.154]:65472 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751241AbVLXPUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 10:20:48 -0500
Message-ID: <43AD674F.1040008@comcast.net>
Date: Sat, 24 Dec 2005 10:20:47 -0500
From: Ed Sweetman <safemode@comcast.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: pci-dma disables iommu on nforce4 motherboards?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an asus A8N-E motherboard and recieve the following message on 
boot. 

PCI-DMA: Disabling IOMMU.

I have no issues with anything not functioning.  I guess i'm just 
curious as to why this is done and if i'm missing out on any sort of 
performance gain by not using the iommu.   I have less than 4GB of ram, 
would that be why it's disabled (which is why i think it is)?  
