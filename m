Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbVHMSxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbVHMSxY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 14:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbVHMSxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 14:53:24 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:8373 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932190AbVHMSxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 14:53:23 -0400
Subject: Re: [Patch] Support UTF-8 scripts
From: Lee Revell <rlrevell@joe-job.com>
To: Hugo Mills <hugo-lkml@carfax.org.uk>
Cc: Stephen Pollei <stephen.pollei@gmail.com>,
       "Martin v." =?ISO-8859-1?Q?L=F6wis?= <martin@v.loewis.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050813184951.GA8283@carfax.org.uk>
References: <42FDE286.40707@v.loewis.de>
	 <feed8cdd0508130935622387db@mail.gmail.com>
	 <1123958572.11295.7.camel@mindpipe>  <20050813184951.GA8283@carfax.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Date: Sat, 13 Aug 2005 14:53:20 -0400
Message-Id: <1123959201.11295.9.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.7 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-08-13 at 19:49 +0100, Hugo Mills wrote:
> On Sat, Aug 13, 2005 at 02:42:52PM -0400, Lee Revell wrote:
> > On Sat, 2005-08-13 at 09:35 -0700, Stephen Pollei wrote:
> > > Thats great for the perl6 people.
> > > http://dev.perl.org/perl6/doc/design/syn/S03.html says they are going
> > > to be using « and » as operators...
> > 
> > Is Larry smoking crack?  That's one of the worst ideas I've heard in a
> > long time.  There's no easy way to enter those at the keyboard!
> 
>    I have "setxkbmap -symbols 'en_US(pc102)+gb'" in my ~/.xsession,
> and « and » are available as AltGr-z and AltGr-x respectively.

Most keyboards don't have an AltGr key.

Lee

