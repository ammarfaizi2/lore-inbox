Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbULDWFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbULDWFF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 17:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbULDWFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 17:05:05 -0500
Received: from services.cse.ucsc.edu ([128.114.48.10]:27380 "EHLO
	services.cse.ucsc.edu") by vger.kernel.org with ESMTP
	id S261177AbULDWFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 17:05:02 -0500
Date: Sat, 4 Dec 2004 14:05:00 -0800 (PST)
From: Lan Xue <lanxue@soe.ucsc.edu>
X-X-Sender: lanxue@moondance.cse.ucsc.edu
To: netdev@oss.sgi.com
cc: kernerl mail <linux-kernel@vger.kernel.org>
Subject: global memory access
In-Reply-To: <20041202094433.39132.qmail@web41411.mail.yahoo.com>
Message-ID: <Pine.GSO.4.58.0412041401570.28362@moondance.cse.ucsc.edu>
References: <20041202094433.39132.qmail@web41411.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was wondering how a user-level program can share a writable memory
buffer with the kernel. The memory can either belongs to the kernel space
or the user space, but both kernel module and user program should be able
to access(read, write) it.

Any hint? Many thanks,

Lan

