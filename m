Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263362AbTJBOiQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 10:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263363AbTJBOiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 10:38:16 -0400
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:41194 "EHLO
	wisbech.cl.cam.ac.uk") by vger.kernel.org with ESMTP
	id S263362AbTJBOiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 10:38:13 -0400
To: karim@opersys.com
cc: xen-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Xen-devel] Re: [ANNOUNCE] Xen high-performance x86 virtualization 
In-Reply-To: Your message of "Thu, 02 Oct 2003 10:25:00 EDT."
             <3F7C353C.4050109@opersys.com> 
Date: Thu, 02 Oct 2003 15:37:38 +0100
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Message-Id: <E1A54aL-000576-00@wisbech.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > We are pleased to announce the first stable release of the Xen
> > virtual machine monitor for x86, and port of Linux 2.4.22 as a
> > guest OS.
> 
> Any plans for porting Xen to other architectures?

Our aim was to implement an efficient VMM for commodity hardware, and
that really means x86. We're considering a port to x86-64, but so far
we're limited in man power (this is why *BSD is not yet available, for
example). 

 -- Keir
