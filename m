Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbVCWH5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbVCWH5T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 02:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262859AbVCWHzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 02:55:50 -0500
Received: from [218.1.67.73] ([218.1.67.73]:57248 "EHLO trust-mart.com")
	by vger.kernel.org with ESMTP id S261483AbVCWHyp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 02:54:45 -0500
Message-ID: <034c01c52f7d$85843a20$d87f11ac@hv>
From: "hv" <hv@trust-mart.com>
To: <linux-kernel@vger.kernel.org>
Subject: memory size
Date: Wed, 23 Mar 2005 15:54:19 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="gb2312";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.3790.1289
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.1289
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,all:
This is my memory status from "dmesg":
Memory: 4673020k/5242880k available (1334k kernel code, 44532k reserved, 
672k data, 156k init, 3800960k highmem)


But I found that available memory size is much less than physical memory 
size.My server is Dell6650 with P4 Xeon*4 and 5G Ram.
My kernel version is 2.6.12-rc1-mm1.Could any one tell my the reason?Thanks. 


