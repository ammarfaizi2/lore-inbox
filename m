Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264595AbSIQUD7>; Tue, 17 Sep 2002 16:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264596AbSIQUD7>; Tue, 17 Sep 2002 16:03:59 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:58252 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S264595AbSIQUD6>; Tue, 17 Sep 2002 16:03:58 -0400
Date: Tue, 17 Sep 2002 13:05:35 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Duc Vianney <dvianney@us.ibm.com>, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Hyperthreading performance on 2.4.19 and 2.5.32
Message-ID: <49950000.1032293135@flay>
In-Reply-To: <3D878A90.F5E4B8B0@us.ibm.com>
References: <3D878A90.F5E4B8B0@us.ibm.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Benchmarks. For multithreaded benchmarks: chat, dbench and tbench.
> Summary of results. The results on Linux kernel 2.4.19 show HT might
> improve multithreaded application by as much as 30%. On kernel 2.5.32,
> HT may provide speed-up as high as 60%.

What happened to the -38% degradation you found? That seems to have
fallen off the results list for some reason ... did you fix it, or is it still there?

M.


