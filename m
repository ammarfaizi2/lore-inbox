Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263159AbUEWQdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263159AbUEWQdf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 12:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263162AbUEWQdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 12:33:35 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:59008 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id S263159AbUEWQde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 12:33:34 -0400
Message-Id: <200405231633.i4NGXHv18935@pincoya.inf.utfsm.cl>
To: Linus Torvalds <torvalds@osdl.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, vonbrand@inf.utfsm.cl
Subject: Re: [RFD] Explicitly documenting patch submission 
In-reply-to: Your message of "Sat, 22 May 2004 23:46:29 MST."
             <Pine.LNX.4.58.0405222341380.18601@ppc970.osdl.org> 
X-mailer: MH [Version 6.8.4]
X-charset: ISO_8859-1
Date: Sun, 23 May 2004 12:33:17 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> said:
> This is a request for discussion..

[...]

> So, to avoid these kinds of issues ten years from now, I'm suggesting that 
> we put in more of a process to explicitly document not only where a patch 
> comes from (which we do actually already document pretty well in the 
> changelogs), but the path it came through. 

How will the path be preserved? Does BK do it now? Can it be transferred
into CVS (for paranoid CVS-won't-screw-us-ever people)? Does this mean
that only the repositories contain the certificates, "final source"
doesn't?

[...]

> To keep the rules as simple as possible, and yet making it clear what it
> means to sign off on the patch, I've been discussing a "Developer's
> Certificate of Origin" with a random collection of other kernel
> developers (mainly subsystem maintainers).  This would basically be what
> a developer (or a maintainer that passes through a patch) signs up for
> when he signs off, so that the downstream (upstream?) developers know
> that it's all ok:
> 
> 	Developer's Certificate of Origin 1.0

[Nice idea snipped]

Just make sure the relevant open source licenses are in Documentation, and
so is the Certificate du jour. And hash out ideas/scripts to retrieve
proof(s) of origin for a particular line (consider its convoluted history,
originated by Joe Random Hacker, modified by Jane Random and rewritten by
Al Hacker, even Aunt Tillie might have touched it ;-).
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
