Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267489AbTACLCk>; Fri, 3 Jan 2003 06:02:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267490AbTACLCk>; Fri, 3 Jan 2003 06:02:40 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:25555 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267489AbTACLCj>;
	Fri, 3 Jan 2003 06:02:39 -0500
Date: Fri, 3 Jan 2003 11:09:01 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: odd phenomenon.
Message-ID: <20030103110901.GC2567@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	William Lee Irwin III <wli@holomorphy.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20030103103816.GA2567@codemonkey.org.uk> <20030103104809.GD9704@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030103104809.GD9704@holomorphy.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 03, 2003 at 02:48:09AM -0800, William Lee Irwin III wrote:
 > > It's almost 100% reproducable here.  Only seen it do it on this box
 > > though which is a P4 with HT, so it could be SMP related..
 > > Ideas ?
 > (1) strace?

That was my first thought. Everything works as expected though
when you try to strace it.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
