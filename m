Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261668AbUFJQd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbUFJQd0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 12:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbUFJQd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 12:33:26 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:38807 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261668AbUFJQdZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 12:33:25 -0400
Date: Thu, 10 Jun 2004 09:42:08 -0700
From: Paul Jackson <pj@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: mikpe@csd.uu.se, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6.7-rc3-mm1] perfctr cpumask cleanup
Message-Id: <20040610094208.079149f1.pj@sgi.com>
In-Reply-To: <20040610160350.GB1444@holomorphy.com>
References: <200406092050.i59KoWoa000621@alkaid.it.uu.se>
	<20040609154750.241df741.pj@sgi.com>
	<16584.9947.222378.506457@alkaid.it.uu.se>
	<20040610090157.04fa62ee.pj@sgi.com>
	<20040610160350.GB1444@holomorphy.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin wrote:
> Please get some cross-compilers together so we don't have every non-x86
> arch exploding at once.  Alpha vs. cpu_possible_map was horrendous.

Yes sir.

Randy Dunlap wrote:
> or submit such patches to OSDL PLM.

That too.

I'm reminded of the old saw:

  Fools rush in where angels fear to tread.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
