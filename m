Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425207AbWLHIxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425207AbWLHIxZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 03:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425213AbWLHIxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 03:53:25 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:37658 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1425207AbWLHIxY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 03:53:24 -0500
Message-ID: <0c1101c71aa6$8e4aab60$eeeea8c0@aldipc>
From: "roland" <devzero@web.de>
To: "Fengguang Wu" <fengguang.wu@gmail.com>
Cc: "Andrew Morton" <akpm@osdl.org>, "Jay Lan" <jlan@engr.sgi.com>,
       <linux-kernel@vger.kernel.org>, <lserinol@gmail.com>
References: <20060928151409.f0a9bda7.akpm@osdl.org> <0bb201c71a5d$1125a930$eeeea8c0@aldipc> <365540925.17780@ustc.edu.cn>
Subject: Re: I/O statistics per process
Date: Fri, 8 Dec 2006 09:55:04 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this is really great news!

thank you!


----- Original Message ----- 
From: "Fengguang Wu" <fengguang.wu@gmail.com>
To: "roland" <devzero@web.de>
Cc: "Andrew Morton" <akpm@osdl.org>; "Jay Lan" <jlan@engr.sgi.com>; 
<linux-kernel@vger.kernel.org>; <lserinol@gmail.com>
Sent: Friday, December 08, 2006 2:22 AM
Subject: Re: I/O statistics per process


> Hi,
>
> On Fri, Dec 08, 2006 at 01:09:01AM +0100, roland wrote:
>>
>> didn`t discover that there is anything new about this (andrew? jay?) or 
>> if
>> some other person sent a patch , but i`d like to report that i came 
>> across
>> a really nice tool which would immediately benefit from per-process i/o
>> statistics feature.
>
> Andrew has added kernel support to it in -mm tree.
> Check this commit log:
> http://www.mail-archive.com/mm-commits@vger.kernel.org/msg02975.html
>
> io-accounting-core-statistics.patch
> io-accounting-write-accounting.patch
> io-accounting-write-cancel-accounting.patch
> io-accounting-read-accounting-2.patch
> io-accounting-read-accounting-nfs-fix.patch
> io-accounting-read-accounting-cifs-fix.patch
> io-accounting-direct-io.patch
> io-accounting-report-in-procfs.patch
> io-accounting-via-taskstats.patch
> io-accounting-add-to-getdelays.patch
>
> Regards,
> Fengguang Wu 

