Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263395AbTJBOsc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 10:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263397AbTJBOsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 10:48:32 -0400
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:30443 "EHLO
	wisbech.cl.cam.ac.uk") by vger.kernel.org with ESMTP
	id S263395AbTJBOsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 10:48:31 -0400
To: karim@opersys.com
cc: xen-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Xen-devel] Re: [ANNOUNCE] Xen high-performance x86 virtualization 
In-Reply-To: Your message of "Thu, 02 Oct 2003 10:45:37 EDT."
             <3F7C3A11.3060009@opersys.com> 
Date: Thu, 02 Oct 2003 15:48:19 +0100
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Message-Id: <E1A54kd-0005EQ-00@wisbech.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Our aim was to implement an efficient VMM for commodity hardware, and
> > that really means x86. We're considering a port to x86-64, but so far
> > we're limited in man power (this is why *BSD is not yet available, for
> > example). 
> 
> I understand. Obviously infinite resources are everyone's wish ;)
> 
> What type of an effort would it be to port Xen to a new architecture?
> I haven't looked at the code, so I can't say, but I'm really looking for
> a rough approximation: 1 man-month, 10 man-months, 100 man-months?

I did most of the arch-dependent Xen implementation myself, and that
took around 2-3 man-months. But x86-64 is not a million miles from x86,
so it wouldn't be a complete port.

My guess is it would take one or two competent-hacker-months. :-)

 -- Keir
