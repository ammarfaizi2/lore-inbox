Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263625AbTKXHmp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 02:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263627AbTKXHmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 02:42:45 -0500
Received: from [217.113.73.39] ([217.113.73.39]:48408 "EHLO
	entandikwa.ds.co.ug") by vger.kernel.org with ESMTP id S263625AbTKXHmn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 02:42:43 -0500
Subject: Re: Nick's scheduler v19a
From: "Peter C. Ndikuwera" <pndiku@dsmagic.com>
To: Markus =?ISO-8859-1?Q?H=E4stbacka?= <midian@ihme.org>
Cc: Timothy Miller <miller@techsource.com>,
       Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <1069434035.21039.5.camel@midux>
References: <3FB62608.4010708@cyberone.com.au>
	 <1069361130.13479.12.camel@midux> <3FBD4F6E.3030906@cyberone.com.au>
	 <1069395102.16807.11.camel@midux> <3FBDAE99.9050902@cyberone.com.au>
	 <1069405566.18362.5.camel@midux> <3FBDD790.5060401@cyberone.com.au>
	 <1069407179.18505.11.camel@midux>  <yw1xy8uaujv0.fsf@kth.se>
	 <1069410094.18790.2.camel@midux>  <3FBE3B0D.8030501@techsource.com>
	 <1069434035.21039.5.camel@midux>
Content-Type: text/plain; charset=ISO-8859-1
Organization: Digital Solutions Ltd
Message-Id: <1069659917.14144.113.camel@mufasa.ds.co.ug>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 Rubber Turnip www.usr-local-bin.org 
Date: Mon, 24 Nov 2003 10:45:17 +0300
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, you could try using XFree86's supplied "nv" driver to test without
the binary nvidia module.

Timothy's point is valid IMO - your help in identifying the bug will
help someone else down the road.

Peter C. Ndikuwera
Digital Solutions Ltd, Uganda

On Fri, 2003-11-21 at 20:00, Markus Hästbacka wrote:
> Yes, but how could I know if the bug is in XFree86? in kernel? in the
> nvidia driver module? and no, I can't even hope to try to reproduce bugs
> without nvidia module, because no X => no bugs. If you tell me what I
> need to add to kernel configuration to get some info while something
> happens, I'll probably try to reproduce bugs when test10 is out with
> vanilla kernel.
> 
> And yes, I'm intrested in the performance of other's computers too, but
> if this is new then it's new, and I can't by my self know where the bug
> (maybe) is.
> 
> Regards,
> Markus
> 
> On Fri, 2003-11-21 at 18:19, Timothy Miller wrote:
> > Markus Hästbacka wrote:
> > > That may be true, but why should I complain anymore? Nick made a really
> > > great patch that makes things working for me.
> > > 
> > 
> > 
> > Are you interested only in the performance of your own computer, or do 
> > you have any interest in the performance of other people's computers as 
> > well?
> > 
> > If there's a bug, there's a bug, and you've identified it.  Contrary to 
> > the attitude of our friends in Redmond, the open source community tends 
> > to see bugs as being really evil.  If you've found a bug, we want to 
> > investigate it and fix it.

