Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270623AbTGNNrw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 09:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270434AbTGNNpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 09:45:30 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:35265 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S270613AbTGNNoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 09:44:37 -0400
Date: Mon, 14 Jul 2003 10:56:59 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: John Bradford <john@grabjohn.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
Subject: Re: Linux v2.6.0-test1
In-Reply-To: <1058182417.561.47.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.55L.0307141055530.18257@freak.distro.conectiva>
References: <200307141139.h6EBd09g000700@81-2-122-30.bradfords.org.uk>
 <1058182417.561.47.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 14 Jul 2003, Alan Cox wrote:

> On Llu, 2003-07-14 at 12:39, John Bradford wrote:
> > > > > The point of the test versions is to make more people realize that they
> > > > > need testing
> > > >
> > > > Are all the known security issues in 2.4 now fixed in 2.6.0-test1?
> > >
> > > No, and several more have been added in 2.6-test only.
> >
> > As far as I know, they are only information disclosure ones, not
> > directly exploitable vulnerabilities, or am I wrong?
>
> Last time I checked there were remote DoS attacks and local root attacks
> present in 2.5.7x
>
> > > > This has been the only major reason for keeping of most of my
> > > > production machines running 2.4 for quite a while.  If not, can we get
> > > > the fixes in at the earliest opportunity?
> > >
> > > Sure.. send the fixes to Linus
> >
> > Is anybody even keeping track of this, though?  Picking thorough LKML
> > to see what did and didn't go in doesn't seem particularly exciting to
> > me.
>
> Then you'll just have to wait a few months

I will start looking at 2.4 security fixes which are not applied in 2.6.

If someone is already doing that, please tell me.
