Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262454AbTJBPP7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 11:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263356AbTJBPP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 11:15:59 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:4992 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S262454AbTJBPP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 11:15:58 -0400
Date: Thu, 2 Oct 2003 16:15:01 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200310021515.h92FF1N3000239@81-2-122-30.bradfords.org.uk>
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>, karim@opersys.com
Cc: xen-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <E1A54aL-000576-00@wisbech.cl.cam.ac.uk>
References: <E1A54aL-000576-00@wisbech.cl.cam.ac.uk>
Subject: Re: [Xen-devel] Re: [ANNOUNCE] Xen high-performance x86 virtualization 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Keir Fraser <Keir.Fraser@cl.cam.ac.uk>:
> 
> > > We are pleased to announce the first stable release of the Xen
> > > virtual machine monitor for x86, and port of Linux 2.4.22 as a
> > > guest OS.
> > 
> > Any plans for porting Xen to other architectures?
> 
> Our aim was to implement an efficient VMM for commodity hardware, and
> that really means x86. We're considering a port to x86-64, but so far
> we're limited in man power (this is why *BSD is not yet available, for
> example). 

Does it run recursively?  I.E. can you can Xen within a Xen virtual
machine for development and testing purposes?

John.
