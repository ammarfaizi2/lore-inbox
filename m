Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268802AbUHTXds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268802AbUHTXds (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 19:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268803AbUHTXdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 19:33:47 -0400
Received: from ozlabs.org ([203.10.76.45]:26604 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268802AbUHTXdk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 19:33:40 -0400
Date: Sat, 21 Aug 2004 09:31:26 +1000
From: Anton Blanchard <anton@samba.org>
To: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       Jesse Barnes <jbarnes@engr.sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm3
Message-ID: <20040820233126.GJ1945@krispykreme>
References: <20040820031919.413d0a95.akpm@osdl.org> <200408201144.49522.jbarnes@engr.sgi.com> <200408201257.42064.jbarnes@engr.sgi.com> <20040820115541.3e68c5be.akpm@osdl.org> <20040820200248.GJ11200@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040820200248.GJ11200@holomorphy.com>
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Parallel compilation is an extremely poor benchmark in general, as the
> workload is incapable of being effectively scaled to system sizes, the
> linking phase is inherently unparallelizable and the compilation phase
> too parallelizable to actually stress anything. There is also precisely
> zero relevance the benchmark has to anything real users would do.

I spend most of my life compiling kernels and I consider myself a real
user :)

Anton
