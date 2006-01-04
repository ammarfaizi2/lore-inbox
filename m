Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750949AbWADXZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbWADXZg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 18:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751840AbWADXZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 18:25:36 -0500
Received: from xproxy.gmail.com ([66.249.82.204]:9185 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750949AbWADXZf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 18:25:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=X6J8/esE2FlFkTwUVvNZ5IgPDjc+DoxILfnUBhgBJtmJm82PFBJq6Ut8hLBCLgIYpUJotnQtTgElctgvphps3F7cinCfeuXKMD/r9XoyFly+rclAfoDVogeBA+FBvMj9k4GtjOuEkCLM7+h0kLPWywxPok6LYDEIheu5cwKgMho=
Message-ID: <4d8e3fd30601041525i4e23e3bbl26ad3590c2dd80ac@mail.gmail.com>
Date: Thu, 5 Jan 2006 00:25:34 +0100
From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH] MAINTAINERS file: Fix missing colon
Cc: "John L. Villalovos" <john.l.villalovos@intel.com>,
       linux-kernel@vger.kernel.org, trivial@rustcorp.com.au,
       torvalds@osdl.org
In-Reply-To: <Pine.LNX.4.58.0601041406210.19134@shark.he.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43BC45DE.5060303@intel.com>
	 <Pine.LNX.4.58.0601041406210.19134@shark.he.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/06, Randy.Dunlap <rdunlap@xenotime.net> wrote:
> On Wed, 4 Jan 2006, John L. Villalovos wrote:
>
> > From: John L. Villalovos <john.l.villalovos@intel.com>
> >
> > While parsing the MAINTAINERS file I disovered one entry was missing a colon.
> > This patch adds the one missing colon.
> >
> > ---
> > diff -r 8441517e7e79 MAINTAINERS
> > --- a/MAINTAINERS       Thu Jan  5 04:00:05 2006
> > +++ b/MAINTAINERS       Wed Jan  4 13:49:27 2006
> > @@ -681,7 +681,7 @@
> >
> >   DAC960 RAID CONTROLLER DRIVER
> >   P:     Dave Olien
> > -M      dmo@osdl.org
> > +M:     dmo@osdl.org
> >   W:     http://www.osdl.org/archive/dmo/DAC960
> >   L:     linux-kernel@vger.kernel.org
> >   S:     Maintained
>
> That would be helpful except that Dave is no longer at OSDL
> and is no longer maintaining that driver...

I don't know who I should CC to this email but it seems it's time to
update http://developer.osdl.org/dev/people/ since Dave is still
listed as an OSDL developer.

--
Paolo
