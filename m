Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267387AbTAVIoZ>; Wed, 22 Jan 2003 03:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267388AbTAVIoZ>; Wed, 22 Jan 2003 03:44:25 -0500
Received: from mta05bw.bigpond.com ([139.134.6.95]:24780 "EHLO
	mta05bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S267387AbTAVIoY> convert rfc822-to-8bit; Wed, 22 Jan 2003 03:44:24 -0500
Content-Type: text/plain; charset=US-ASCII
From: Srihari Vijayaraghavan <harisri@bigpond.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: 2.4.21-pre3aa1 and RAID0 issue (was: 2.4.21-pre2aa1 - RAID0 issue.)
Date: Wed, 22 Jan 2003 20:07:48 +1100
User-Agent: KMail/1.4.3
References: <200212270856.13419.harisri@bigpond.com>
In-Reply-To: <200212270856.13419.harisri@bigpond.com>
Cc: Andrea Arcangeli <andrea@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301222007.48055.harisri@bigpond.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Friday 27 December 2002 08:56, Srihari Vijayaraghavan wrote:
> [1.] One line summary of the problem:
> 2.4.20-pre2aa1 hangs while trying to bringup software RAID0 volumes,
> 2.4.21-pre2 and 2.4.20-aa1 are fine with the same volumes.

The RAID0 doesn't work in 2.4.21-pre3aa1 in my computer, while it is fine with 
2.4.21-pre3 and 2.4.20-aa1.

The hardware and software details continue to be the same as per the previous 
report ( http://marc.theaimsgroup.com/?l=linux-kernel&m=104093932820352&w=2 
).

Please cc me if you can, sorry if it is a known issue. Thanks.
-- 
Hari
harisri@bigpond.com

