Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266443AbTAYNJs>; Sat, 25 Jan 2003 08:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266453AbTAYNJs>; Sat, 25 Jan 2003 08:09:48 -0500
Received: from [81.2.122.30] ([81.2.122.30]:5380 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S266443AbTAYNJs>;
	Sat, 25 Jan 2003 08:09:48 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301251319.h0PDJUEr000212@darkstar.example.net>
Subject: Re: Server down?
To: matti.aarnio@zmailer.org (Matti Aarnio)
Date: Sat, 25 Jan 2003 13:19:29 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030125125321.GP787@mea-ext.zmailer.org> from "Matti Aarnio" at Jan 25, 2003 02:53:21 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Lets see what logs tell:
> > > 
> > >     @grabjohn.com linux-kernel relaying denied
> > > 
> > > Cases of "relaying denied" (wording varies) are fairly easy to understand.
> > 
> > I *know* that one of my backup mailers is incorrectly configured, but
> > that machine is not under my direct control, and I have asked for it
> > to be re-configured.  What else can I do?
> 
> Change your MX dataset to omit the incorrectly configured system ?
> 
> If you can't control your DNS MX sets either, well, at least you can
> read the lists via various archives, and can always post to the list
> independent of subscription status.

Oh, I'm subscribed to the list as john@bradfords.org.uk, which I have
full control over - there shouldn't be bounces to that address.

You're right, though, to be honest the usa-relay is rather unncessary
anyway - the two other servers provide enough redundancy.  I'll remove
it.

John.
