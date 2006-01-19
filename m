Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751384AbWASQww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbWASQww (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 11:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbWASQww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 11:52:52 -0500
Received: from bay109-f26.bay109.hotmail.com ([64.4.19.36]:34201 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S1751384AbWASQwv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 11:52:51 -0500
Message-ID: <BAY109-F267E92D32B75385FDB680DD61C0@phx.gbl>
X-Originating-IP: [61.247.248.51]
X-Originating-Email: [agovinda04@hotmail.com]
From: "govind raj" <agovinda04@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: RAID 5+0 support
Date: Thu, 19 Jan 2006 22:22:50 +0530
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 19 Jan 2006 16:52:51.0113 (UTC) FILETIME=[C8C0B190:01C61D18]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

We are using EVMS 2.5.4 on Linux 2.6.12.6 kernel version.

We find that kernel modules are available for RAID0, 1, 5, 1+0 as part of 
this kernel. But however, we do not find a similar module available for RAID 
5+0. Can someone advise us of how we would be able to get this support added 
into the kernel? If this is not required as a kernel module, how do we 
create a RAID 5+0 using MD?

Thanks in advance for your help,

Govind


