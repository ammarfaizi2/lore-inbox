Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271165AbUJVCXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271165AbUJVCXr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 22:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271168AbUJVCU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 22:20:57 -0400
Received: from c3p0.cc.swin.edu.au ([136.186.1.30]:10515 "EHLO swin.edu.au")
	by vger.kernel.org with ESMTP id S271165AbUJVCSn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 22:18:43 -0400
To: Greg Buchholz <linux@sleepingsquirrel.org>
Cc: linux-kernel@vger.kernel.org
From: Tim Connors <tconnors+linuxkernel1098411255@astro.swin.edu.au>
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
In-reply-to: <20041021170808.GA675@sleepingsquirrel.org>
References: <20041021170808.GA675@sleepingsquirrel.org>
X-test-to: Greg Buchholz <linux@sleepingsquirrel.org>
X-cc-to: linux-kernel@vger.kernel.org
X-reply-to-bofh-messageid: <2ROVu-7du-47@gated-at.bofh.it>
X-Face: A>QmH)/u`[d}b.a5?Xq=L&d?Q}cF5x|wu#O_mAK83d(Tw,BjxX[}n4<13.e$"d!Gg(I%n8fL)I9fZ$0,8s3_5>iI]4c%FXg{CpVhuIuyI,W'!5Cl?5M,dL-*dHYs}K9=YQZCN-\2j1S>cU6XPXsQhz$x`M\ZEV}nPw'^jPc41FiwTQZ'g)xNK{2',](o5mrODBHe))
Message-ID: <slrn-0.9.7.4-14727-1584-200410221214-tc@hexane.ssi.swin.edu.au>
Date: Fri, 22 Oct 2004 12:18:23 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Buchholz <linux@sleepingsquirrel.org> said on Thu, 21 Oct 2004 10:08:08 -0700:
> Stephen Wille Padnos wrote:
> >I guess I would look at this as an opportunity to make a "visual
> >coprocessor", that also has the hardware necessary to output to a
> >monitor (preferably multiple monitors).
> 
>     This idea is a step in the right direction.  To make the project
> viable, you might be better off trying to court a slightly different
> audience (instead of the cost-sensitive/3D-performant market).  What if
> instead, you were selling a highly parallel reprogrammable computing
> core, which also happened to do graphics?  I could see a potentially
> much bigger and higher profit margin market for a standardized interface
> from Linux to an FPGA.  Image people buying them for headless servers as
> crypto accellerators.  Or as DSP/FFT accellerators (for speech
> recognition , MPEG compression, or whatever).  I'm sure you'd sell a few
> to grad students writing theses on data flow machines, parallel
> languages, prime factorization etc.  Heck, I'd buy one just because it'd
> be cool to try and write a 1000 element merge sort in hardware that
> completed in one or two clock cycles.  It's not hard to imaging people
> using it to speed up emulators like QEMU.  Maybe the distributed
> computing folks (Folding@Home, SETI) would also be interested, since
> their work is already highly parallelizable.  You get the idea. 

People would happily pay millions for this.

Tim has probably heard of Grape?

I don't know whether grape uses FPGAs or not, but take a look at the
photo down the bottom of this:

http://grape.c.u-tokyo.ac.jp/~fukushig/paper/sc96/sc96.html

I reckon if we could put an accelarator card in each of our 200 new
machines, that could be programmed on the fly to do N-body
calculations, or then changed to do SPH, or whatever, and we only had
to pay $500 per card, and it doubled performace, we'd do it in a
second. Half the number of computers, drop energy consumption (and
cooling), etc. It'd be great.


-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/
A mouse is a device used to focus xterms.
