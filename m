Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267863AbTAHTny>; Wed, 8 Jan 2003 14:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267865AbTAHTnx>; Wed, 8 Jan 2003 14:43:53 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:31208 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267863AbTAHTnw>;
	Wed, 8 Jan 2003 14:43:52 -0500
Date: Wed, 8 Jan 2003 19:50:00 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Robert Love <rml@tech9.net>, Adrian Bunk <bunk@fs.tum.de>,
       "Robert P. J. Day" <rpjday@mindspring.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: observations on 2.5 config screens
Message-ID: <20030108195000.GA670@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Bill Davidsen <davidsen@tmr.com>, Robert Love <rml@tech9.net>,
	Adrian Bunk <bunk@fs.tum.de>,
	"Robert P. J. Day" <rpjday@mindspring.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <1042041195.694.2734.camel@phantasy> <Pine.LNX.3.96.1030108132758.22872B-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1030108132758.22872B-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2003 at 01:36:06PM -0500, Bill Davidsen wrote:

 > I guess, depending on your definition of fundemental. I would put any
 > option which affects the kernel as a whole in that category, myself.
 > Compiling with frame pointers comes to mind, since every object file is
 > changed and there are performance implications as well.

No-one other than kernel hackers should be playing with that option,
hence it's in the kernel hacking menu.

 > Processor option would select the processor and any architecture dependent
 > options, I would think. Something like "kernel characteristics" could have
 > options like smp.

SMP isn't a processor option ?

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
