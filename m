Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263380AbUFFMUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263380AbUFFMUs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 08:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263415AbUFFMUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 08:20:48 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:45414 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263380AbUFFMUp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 08:20:45 -0400
Date: Sun, 6 Jun 2004 05:28:43 -0700
From: Paul Jackson <pj@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: rusty@rustcorp.com.au, mikpe@csd.uu.se, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based
 implementation
Message-Id: <20040606052843.5bbe16f3.pj@sgi.com>
In-Reply-To: <20040606121327.GT21007@holomorphy.com>
References: <20040604095929.GX21007@holomorphy.com>
	<16576.23059.490262.610771@alkaid.it.uu.se>
	<20040604112744.GZ21007@holomorphy.com>
	<20040604113252.GA21007@holomorphy.com>
	<20040604092316.3ab91e36.pj@sgi.com>
	<20040604162853.GB21007@holomorphy.com>
	<20040604104756.472fd542.pj@sgi.com>
	<20040604181233.GF21007@holomorphy.com>
	<1086487651.11454.19.camel@bach>
	<20040606051657.3c9b44d3.pj@sgi.com>
	<20040606121327.GT21007@holomorphy.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You've been told, and several times already. The current example is
> userspace needing to know when to stop trying to online cpus.

To which I've answered, you are describing cpu_possible_map,
cpu_present_map and cpu_online_map, not NR_CPUS.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
