Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267509AbSLSHCx>; Thu, 19 Dec 2002 02:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267543AbSLSHCw>; Thu, 19 Dec 2002 02:02:52 -0500
Received: from pby.osdl.jp ([202.221.206.21]:50305 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id <S267509AbSLSHCv>;
	Thu, 19 Dec 2002 02:02:51 -0500
Subject: Re: Freezing.. (was Re: Intel P6 vs P7 system call performance)
From: "Timothy D. Witham" <wookie@osdl.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <747650000.1040281526@titus>
References: <200212181908.gBIJ82M03155@devserv.devel.redhat.com>
	 <1040276082.1476.30.camel@localhost.localdomain>
	 <747650000.1040281526@titus>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Open Source Development Lab, Inc.
Message-Id: <1040278110.1478.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 18 Dec 2002 22:08:30 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Sorry, they changed it last week and my fingers still
have the old firmware. 

  www.osdl.org/cgi-bin/plm

TIm

On Wed, 2002-12-18 at 23:05, Martin J. Bligh wrote:
> > Related thought:
> >
> >   One of the things that we are trying to do is to automate
> > patch testing.
> >
> >   The PLM (www.osdl.org/plm) takes every patch that it gets
> > and does a quick "Does it compile test".  Right now there
> > are only 4 kernel configuration files that we try but we are
> > going to be adding more.  We could expand this to 100's
> > if needed as it would just be a matter of adding additional
> > hardware to make the compiles go faster in parallel.
> 
> URL doesn't seem to work. But would be cool if you had one SMP
> config, one UP with IO/APIC, and one without IO/APIC. I seem
> to break the middle one whenever I write a patch ;-(
> 
> M.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Timothy D. Witham - Lab Director - wookie@osdlab.org
Open Source Development Lab Inc - A non-profit corporation
15275 SW Koll Parkway - Suite H - Beaverton OR, 97006
(503)-626-2455 x11 (office)    (503)-702-2871     (cell)
(503)-626-2436     (fax)

