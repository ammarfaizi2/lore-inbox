Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266690AbSKUOcI>; Thu, 21 Nov 2002 09:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266693AbSKUOcI>; Thu, 21 Nov 2002 09:32:08 -0500
Received: from mailout09.sul.t-online.com ([194.25.134.84]:38328 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S266690AbSKUOcH>; Thu, 21 Nov 2002 09:32:07 -0500
Message-Id: <4.3.2.7.2.20021121153829.00b5c7a0@mail.dns-host.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Thu, 21 Nov 2002 15:39:33 +0100
To: linux-kernel@vger.kernel.org
From: Margit Schubert-While <margit@margit.com>
Subject: L1_CACHE_SHIFT value for P4 ?
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just for the record - my x86info

Instruction TLB: 4K, 2MB or 4MB pages, fully associative, 64 entries.
Data TLB: 4KB or 4MB pages, fully associative, 64 entries.
L1 Data cache:
         Size: 8KB       Sectored, 4-way associative.
         line size=64 bytes.
No L3 cache
Instruction trace cache:
         Size: 12K uOps  8-way associative.
L2 unified cache:
         Size: 512KB     Sectored, 8-way associative.
         line size=64 bytes.

