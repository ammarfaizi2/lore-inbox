Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262693AbTCYP6D>; Tue, 25 Mar 2003 10:58:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262695AbTCYP6C>; Tue, 25 Mar 2003 10:58:02 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:12293 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S262693AbTCYP6A>; Tue, 25 Mar 2003 10:58:00 -0500
Date: Tue, 25 Mar 2003 11:04:51 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Thomas Duffy <tduffy@afara.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Deprecating .gz format on kernel.org
In-Reply-To: <1048183475.3427.112.camel@biznatch>
Message-ID: <Pine.LNX.3.96.1030325110027.1437B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Mar 2003, Thomas Duffy wrote:

> On Thu, 2003-03-20 at 09:51, Eli Carter wrote:
> > So, who can beat his 15.10 bogomips?
> 
> my firewall:
> 
> [tduffy@crackho ~]$ more /proc/cpuinfo
> processor       : 0
> vendor_id       : unknown
> cpu family      : 4
> model           : 0
> model name      : 486
> stepping        : unknown
> fdiv_bug        : no
> hlt_bug         : no
> sep_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : no
> fpu_exception   : no
> cpuid level     : -1
> wp              : yes
> flags           :
> bogomips        : 12.44
> 
> -- 
> YOO-ESS-AYE! YOO-ESS-AYE!

At one point I ran Linux on a 386SX-16 with 12MB. That machine ran 1.2.13
(IIRC) until Dec 31 1999, when I was afraid it was not Y2k hardened. I
still see spam to glacial.tmr.com today. The name was NOT because it was
so cool ;-)

I may still have that board, but I'm not about to put it back in service
to measure speed. Your firewall is the slowest "real machine" I've seen,
emulation and embedded machines are not really general purpose.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

