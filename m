Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261701AbVBXB1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261701AbVBXB1U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 20:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261713AbVBXB1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 20:27:20 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:30186 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261701AbVBXB1S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 20:27:18 -0500
Date: Wed, 23 Feb 2005 17:25:51 -0800
From: Paul Jackson <pj@sgi.com>
To: Kaigai Kohei <kaigai@ak.jp.nec.com>
Cc: jlan@sgi.com, akpm@osdl.org, lse-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, guillaume.thouvenin@bull.net,
       tim@physik3.uni-rostock.de, erikj@subway.americas.sgi.com,
       limin@dbear.engr.sgi.com, jbarnes@sgi.com
Subject: Re: [Lse-tech] Re: A common layer for Accounting packages
Message-Id: <20050223172551.6771ce7a.pj@sgi.com>
In-Reply-To: <421C2B99.2040600@ak.jp.nec.com>
References: <42168D9E.1010900@sgi.com>
	<20050218171610.757ba9c9.akpm@osdl.org>
	<421993A2.4020308@ak.jp.nec.com>
	<421B955A.9060000@sgi.com>
	<421C2B99.2040600@ak.jp.nec.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So, I think such a fork/execve/exit hooks is harmless now.

I don't recall seeing any microbenchmarking of the impact on fork/exit
of such hooks.  You might find such a benchmark in lmbench, or at
http://bulk.fefe.de/scalability/.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.650.933.1373, 1.925.600.0401
