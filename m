Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262025AbULPVgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262025AbULPVgw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 16:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262027AbULPVgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 16:36:52 -0500
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:23771 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S262025AbULPVgv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 16:36:51 -0500
To: Andrew Morton <akpm@osdl.org>
cc: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>, ak@suse.de, alan@lxorguk.ukuu.org.uk,
       riel@redhat.com, linux-kernel@vger.kernel.org, Steven.Hand@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk, Keir.Fraser@cl.cam.ac.uk,
       Ian.Pratt@cl.cam.ac.uk
Subject: Re: arch/xen is a bad idea 
In-reply-to: Your message of "Thu, 16 Dec 2004 13:03:30 PST."
             <20041216130330.6f44c244.akpm@osdl.org> 
Date: Thu, 16 Dec 2004 21:36:36 +0000
From: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Message-Id: <E1Cf3Ib-0006dM-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ian Pratt <Ian.Pratt@cl.cam.ac.uk> wrote:
> >
> > I'm not convinced that maintaining xen/i386 in its current form
> >  is going to be as hard as Andi thinks. We already share many
> >  files unmodified from i386.
> 
> How are they shared?  Inclusion, symlinks, makefile references or

The makefile creates symlinks. 

Ian


