Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbTK1ETc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 23:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261965AbTK1ETc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 23:19:32 -0500
Received: from c3p0.cc.swin.edu.au ([136.186.1.30]:31247 "EHLO swin.edu.au")
	by vger.kernel.org with ESMTP id S261957AbTK1ETb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 23:19:31 -0500
To: linux-kernel@vger.kernel.org
From: Tim Connors <tconnors+linuxkernel1069985926@astro.swin.edu.au>
Subject: Re: 2.6 not cat proof
References: <20031126201052.GA16106@outpost.ds9a.nl>
X-Face: "$j_Mi4]y1OBC/&z_^bNEN.b2?Nq4#6U/FiE}PPag?w3'vo79[]J_w+gQ7}d4emsX+`'Uh*.GPj}6jr\XLj|R^AI,5On^QZm2xlEnt4Xj]Ia">r37r<@S.qQKK;Y,oKBl<1.sP8r,umBRH';vjULF^fydLBbHJ"tP?/1@iDFsKkXRq`]Jl51PWN0D0%rty(`3Jx3nYg!
Message-ID: <slrn-0.9.7.4-255-30138-200311281318-tc@hexane.ssi.swin.edu.au>
Date: Fri, 28 Nov 2003 15:19:27 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bert hubert <ahu@ds9a.nl> said on Wed, 26 Nov 2003 21:10:52 +0100:
> This bug has been seen here over eight years ago and it is back.. linux
> 2.6.0-test4 is still not cat proof :-)
> 
> I found my cat asleep on the warm laptop, it is winter here, and the
> keyboard was dead. Mouse still works, but I had to reboot before I could use
> the keyboard again. Restarting X, which I could do with the mouse, did not
> help.

Are you sure he didn't press alt-sysreq-r or something? Mine has at
various times, pressed ctrl-alt-backspace, ctrl-alt-delete,
alt-sysrq-b (without s and u first, bastard), and the power button
directly. This is all on a laptop, so sysrq requires you pressing fn
first.

One of the cats have also turned my heater on by the touch sensetive
buttons, in the middle of summer while I was out for the day. The
heater, and the power button now have molly gaurds, but the key
combinations are hard to gaurd against.

Read the fvwm webpage - most of the developers of fvwm have cats, and
have, IIRC, documented various ways around their key typing
habits. IIRC, there is a package that at least detects when a cat is
walking across a keyboard, and forces you to click the mouse in a
window under X. Won't stop the kernel crashing, but will do something.

In all seriousness, on my laptop, (do to this and other reasons, I
have stopped using 2.6 for the time being), when I pressed h and j (or
something like that) at the same time, when I realeased one of the
keys, I got some kernel warning like "invalid keyscan" or
something. Never wrote it down, sorry.

-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/
When cryptography is outlawed, bayl bhgynjf jvyy unir cevinpl.
