Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266248AbUAVL4r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 06:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266252AbUAVL4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 06:56:47 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:42362 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S266248AbUAVL4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 06:56:46 -0500
Message-Id: <5.1.0.14.2.20040122223108.03217e88@171.71.163.14>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 22 Jan 2004 22:56:37 +1100
To: Mike Fedyk <mfedyk@matchmail.com>, hpa@zytor.com
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: MD Raid compatability between 2.4/2.6
Cc: Jan De Luyck <lkml@kcore.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20040122112628.GR23765@srv-lnx2600.matchmail.com>
References: <200401221059.39223.lkml@kcore.org>
 <200401221059.39223.lkml@kcore.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:26 PM 22/01/2004, Mike Fedyk wrote:
>Yes, as long as you're not trying the new raid6 code (very experemental
>right now).

maybe not quite yet ready for prime-time, but nontheless very impressive in 
terms of performance!

an 8-disk RAID6 array with a chunksize of 64K sustains 92MB/sec streaming 
filesystem throughput here @ 30% CPU utilization.


cheers,

lincoln.

