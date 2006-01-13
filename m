Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422782AbWAMSL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422782AbWAMSL1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 13:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422784AbWAMSL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 13:11:26 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:21934 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1422782AbWAMSL0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 13:11:26 -0500
Date: Fri, 13 Jan 2006 10:10:54 -0800
From: Paul Jackson <pj@sgi.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: akpm@osdl.org, adobriyan@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm2: alpha broken
Message-Id: <20060113101054.d62acb0d.pj@sgi.com>
In-Reply-To: <20060113141154.GL29663@stusta.de>
References: <20060107052221.61d0b600.akpm@osdl.org>
	<20060107210646.GA26124@mipter.zuzino.mipt.ru>
	<20060107154842.5832af75.akpm@osdl.org>
	<20060110182422.d26c5d8b.pj@sgi.com>
	<20060113141154.GL29663@stusta.de>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian wrote:
> This is the amout of testing I can afford.

It sounds to me like you are saying that a minute of your time is
more valuable than a minute of each of several other peoples time.

The only two people I gladly accept that argument from are Linus
and Andrew.

For the rest of us, it is important to minimize the total workload
of all us combined, not to optimize our individual output.

What you don't test, several others of us get to test.  Only its often
more work, for -each- of us, as we each have to figure out which of
1000 patches caused the breakage.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
