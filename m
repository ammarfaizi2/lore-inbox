Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965352AbVKGRf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965352AbVKGRf2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 12:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965351AbVKGRf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 12:35:26 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:22227 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S965305AbVKGRfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 12:35:23 -0500
Subject: Re: 3D video card recommendations
From: Steven Rostedt <rostedt@goodmis.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Toon van der Pas <toon@hout.vanvergehaald.nl>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1131377496.2858.21.camel@laptopd505.fenrus.org>
References: <1131112605.14381.34.camel@localhost.localdomain>
	 <1131349343.2858.11.camel@laptopd505.fenrus.org>
	 <1131367371.14381.91.camel@localhost.localdomain>
	 <20051107152009.GA20807@shuttle.vanvergehaald.nl>
	 <1131377496.2858.21.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 07 Nov 2005 12:35:06 -0500
Message-Id: <1131384906.14381.108.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-07 at 16:31 +0100, Arjan van de Ven wrote:
> On Mon, 2005-11-07 at 16:20 +0100, Toon van der Pas wrote:
> > On Mon, Nov 07, 2005 at 07:42:51AM -0500, Steven Rostedt wrote:
> > > On Mon, 2005-11-07 at 08:42 +0100, Arjan van de Ven wrote:
> > > 
> > > > 5) The vendor goes out of business and thus stops updating the driver
> > > 
> > > MS folks would have the same problem.
> > 
> > ...which proves the point Arjan is making.
> > 
> > For one, I have an ISDN-adapter which doesn't work with any version of
> > MS-Windows from this millennium (no drivers available), while it's still
> > working great on current Linux kernels.
> 
> 
> well despite your post; the Windows people are a lot better at keeping
> old drivers working (win 9x to a NT based kernel was obviously a huge
> change though). In linux you can use an old driver maybe for 6 months if
> you're lucky.. in windows 6 years is no exception. So the problem is a
> lot bigger in linux for the owner of such a card than it is in windows.
> 

Only if the Linux driver is closed source.  Otherwise, the driver should
be upgraded with the kernel.  Most all open source hardware drivers are
already included in the kernel, and maintained as long as there's
someone that has the device that can maintain it.

-- Steve


