Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261285AbUKFDWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbUKFDWS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 22:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbUKFDWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 22:22:18 -0500
Received: from smtpout.mac.com ([17.250.248.86]:50157 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261285AbUKFDWO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 22:22:14 -0500
In-Reply-To: <200411051906.iA5J6XJd014410@laptop11.inf.utfsm.cl>
References: <200411051906.iA5J6XJd014410@laptop11.inf.utfsm.cl>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <01C20E37-2FA3-11D9-857E-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: jp@enix.org, "Adam J. Richter" <adam@yggdrasil.com>,
       linux-kernel@vger.kernel.org, davids@webmaster.com
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Possible GPL infringement in Broadcom-based routers
Date: Fri, 5 Nov 2004 22:21:53 -0500
To: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 05, 2004, at 14:06, Horst von Brand wrote:
> This is nonsense: If so, I'd be commiting a crime each time I fire up 
> emacs
> on Solaris (linking (GPLed) emacs to (propietary) libc in RAM). [Yes, 
> just
> an example; haven't done so for the best part of 5 years now...]

What you do with the GPL _on_your_computer_ is not relevant.  libc is a
standard interface, which is used by many programs, much the same way
that a keyboard is a standard interface to a computer.  You don't see
companies with copyright to _all_ keyboards, do you? ;-D

> Besides, Linus has _explicitly_ said that binary (closed source) 
> modules
> are OK (under certain conditions). And AFAIU there was legitimate
> discussion wether this particular excemption was required at al.

This, of course, would assume that said code is compiled as a module. I
posted earlier some available makefile snippets from the code that they
_do_ distribute that shows they do _not_ link it as a module, but 
directly
into the kernel.  Last I saw, NVidia couldn't distribute kernels with 
their
modules compiled directly into the binary.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a17 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


