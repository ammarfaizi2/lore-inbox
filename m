Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270919AbRHNWth>; Tue, 14 Aug 2001 18:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270917AbRHNWt2>; Tue, 14 Aug 2001 18:49:28 -0400
Received: from cs242719-203.austin.rr.com ([24.27.19.203]:30971 "EHLO
	snafu.haywired.net") by vger.kernel.org with ESMTP
	id <S270916AbRHNWtO>; Tue, 14 Aug 2001 18:49:14 -0400
Date: Tue, 14 Aug 2001 18:12:23 -0500 (CDT)
From: <paulsch@haywired.net>
To: <linux-thinkpad@www.bm-soft.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] mwave_linux-2.4.8 / release mwavem-1.0.2
Message-ID: <Pine.LNX.4.33.0108141809020.16539-100000@screwy.haywired.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The mwave driver and distribution have been updated...  They can be gotten
at the Mwave home page:  http://oss.software.ibm.com/acpmodem/

Questions, comments, etc. are welcome...

Here are the changes:

Version 1.0.2 Source

    * Includes latest 2.4.8 driver patch
	- Fix undefinded __exit for 2.2.x kernels
	- Global s_mdd now prefixed with mwave_ as it should be
	- Bugfixes for initialization failure cases (Thomas Hood)
	- printk cleanups (Hood)
	- Disabling of other UARTs contolled by
MWAVE_FUTZ_WITH_OTHER_DEVICES flag (Hood)
    * ./configure and mwaved fixes for older versions of bash


Cheers...Paul...


-- 

Paul B Schroeder
paulsch@haywired.net


