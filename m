Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318042AbSGRMxw>; Thu, 18 Jul 2002 08:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318047AbSGRMxv>; Thu, 18 Jul 2002 08:53:51 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:60096 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S318042AbSGRMxu>; Thu, 18 Jul 2002 08:53:50 -0400
Date: Thu, 18 Jul 2002 15:14:48 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: NFS can't get request (2.5.26)
In-Reply-To: <15670.44078.141083.237541@charged.uio.no>
Message-ID: <Pine.LNX.4.44.0207181503260.29194-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jul 2002, Trond Myklebust wrote:

> See the FAQ on nfs.sourceforge.net. The above error message indicates
> congestion: either due to slow response from the server or due to some
> networking issue.

100Mbit/FDX crossover cable and stock 2.5.26, there was only about 
256kbytes/s 
going over the line at the time, with 3c905B on both ends.

Sorry, i'll check out the FAQ.

Cheers,
	Zwane Mwaikambo

-- 
function.linuxpower.ca

