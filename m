Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265407AbUEZKJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265407AbUEZKJy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 06:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265409AbUEZKJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 06:09:54 -0400
Received: from grunt22.ihug.com.au ([203.109.249.142]:52895 "EHLO
	grunt22.ihug.com.au") by vger.kernel.org with ESMTP id S265407AbUEZKJ2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 06:09:28 -0400
Subject: Re: drivers DB and id/ info registration
From: Zenaan Harkness <zen@freedbms.net>
To: debian-devel@lists.debian.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200405260918.51589@fortytwo.ch>
References: <1085542706.2908.25.camel@zen8100a.freedbms.net>
	 <20040526065447.GA32304@dat.etsit.upm.es>  <200405260918.51589@fortytwo.ch>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1085566079.2522.54.camel@zen8100a.freedbms.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 26 May 2004 20:07:59 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-05-26 at 17:18, Adrian 'Dagurashibanipal' von Bidder wrote:
> On Wednesday 26 May 2004 08.54, Javier Fernández-Sanguino Peña wrote:
> > On Wed, May 26, 2004 at 01:38:26PM +1000, Zenaan Harkness wrote:
> > > My biggest itch in our free software world is drivers.
> [...]
> > > Does it make sense to set up a centralized website/ DB where
> 
> I always jump when somebody wants to centralize things...

I know how you feel, although this is more from a manufacturers point of
view:

I develop widget X.

I contact microsoft and have X incorporated into windows.

I want to get it into free software kernels ... ???

> OTOH, one place to collect the info would probably be good. Or at least 
> (to start with) one place listing the various places where such info is 
> currently collected. Perhaps this is a case for a Wiki, and then you'll 
> see in what direction this develops.

Might be a good way to start.

> > > hardware manufacturers and individuals can submid hardware info,
> > > and that is widely advertised to hardware companies around the
> > > globe?
> >
> > Yes, it does. I'm not sure if it makes sense to have it
> > distribution-independent. End-users want to see which hardware is
> > supported by their operating system (the current release, not the
> > development release)

The primary intention here is to make it easy for the manufacturers, not
the end users (however a nice searchable interface for users would
assuredly be a side effect).

If I have a device that has multiple connection types (eg. parallel,
usb, ethernet), who do I contact in the free software world? It's
currently not easy/ known.

It could/ should include information (perhaps in wiki or some "user
submissions") about which kernels/ distros currently have support too,
since that is useful information.

> I guess this depends on what this site wishes to do. Should it be a 
> repository for end-users to get information, or should it be a resource 
> for distribution developers to go looking for device identification 
> information?

Primarily for manufacturers to provide/ submit information to.
Therefore the second primary target I guess would be developers.
Thirdly is users.

Thanks
Zenaan
