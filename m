Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317579AbSHHOvV>; Thu, 8 Aug 2002 10:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317591AbSHHOvV>; Thu, 8 Aug 2002 10:51:21 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:27590 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317579AbSHHOvV>; Thu, 8 Aug 2002 10:51:21 -0400
Date: Thu, 08 Aug 2002 07:51:53 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
       Andrew Morton <akpm@zip.com.au>
cc: Anton Blanchard <anton@samba.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org, riel@surriel.com
Subject: Re: fix CONFIG_HIGHPTE
Message-ID: <1417118248.1028793099@[10.10.2.3]>
In-Reply-To: <20020807204332.B5777@nightmaster.csn.tu-chemnitz.de>
References: <20020807204332.B5777@nightmaster.csn.tu-chemnitz.de>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> - We'll continue to suck for the University workload.
> 
> Hop that's not an 2.6 option, because our University alone is
> using Linux on 1000+ machines, on 500+ private machines and lots
> of mission critical servers.
> 
> If Linux becomes crap for the CPU-Server-Load, we would be VERY
> sorry here, since we are pushing it very hard[1].

It'd be helpful if you benchmarked whatever workload you have
comparing 2.4 and 2.5 mainline then ;-) If it sucks, post some
profiling data, and carefully describe what your workload is.

M.

