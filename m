Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263598AbUDOVHc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 17:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263685AbUDOVHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 17:07:32 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:44554 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S263598AbUDOVH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 17:07:29 -0400
Message-ID: <407EF9C4.4070207@techsource.com>
Date: Thu, 15 Apr 2004 17:08:20 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Overlay ramdisk on filesystem?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a feeling that this may be a bit too off-topic, but I'm doing 
some Linux and hardware performance tests, and some of the tests will 
put the hardware into an unstable state which could get memory errors 
which could cause filesystem corruption.

I would like to know how I could overlay a RAM disk over a read-only 
filesystem so that all new files and modified files end up in the RAM 
disk, but old files are read from the disk.  This way, when I reboot, 
the disk reverts back.

Suggestions?

Thanks.

