Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263334AbSIUQ3b>; Sat, 21 Sep 2002 12:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263997AbSIUQ3b>; Sat, 21 Sep 2002 12:29:31 -0400
Received: from franka.aracnet.com ([216.99.193.44]:3991 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S263334AbSIUQ3a>; Sat, 21 Sep 2002 12:29:30 -0400
Date: Sat, 21 Sep 2002 09:32:20 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erich Focht <efocht@ess.nec.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
cc: LSE <lse-tech@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [Lse-tech] [PATCH 1/2] node affine NUMA scheduler
Message-ID: <597807912.1032600740@[10.10.2.3]>
In-Reply-To: <595579668.1032598511@[10.10.2.3]>
References: <595579668.1032598511@[10.10.2.3]>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Anyway, I'm giving your code a quick spin ... will give you some
> results later ;-)

Hmmm .... well I ran the One True Benchmark (tm). The patch 
*increased* my kernel compile time from about 20s to about 28s. 
Not sure I like that idea ;-) Anything you'd like tweaked, or 
more info? Both user and system time were up ... I'll grab a 
profile of kernel stuff.

M.

