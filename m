Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267629AbTALXEu>; Sun, 12 Jan 2003 18:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267628AbTALXEu>; Sun, 12 Jan 2003 18:04:50 -0500
Received: from mta2.srv.hcvlny.cv.net ([167.206.5.5]:18871 "EHLO
	mta2.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S267629AbTALXEs>; Sun, 12 Jan 2003 18:04:48 -0500
Date: Sun, 12 Jan 2003 18:11:41 -0500
From: Rob Wilkens <robw@optonline.net>
Subject: Re: any chance of 2.6.0-test*?
In-reply-to: <20030112225228.GP31238@vitelus.com>
To: Aaron Lehmann <aaronl@vitelus.com>
Cc: Rik van Riel <riel@conectiva.com.br>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-to: robw@optonline.net
Message-id: <1042413101.3162.184.camel@RobsPC.RobertWilkens.com>
Organization: Robert Wilkens
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <Pine.LNX.4.44.0301121100380.14031-100000@home.transmeta.com>
 <1042400094.1208.26.camel@RobsPC.RobertWilkens.com>
 <20030112211530.GP27709@mea-ext.zmailer.org>
 <1042406849.3162.121.camel@RobsPC.RobertWilkens.com>
 <Pine.LNX.4.50L.0301121939170.26759-100000@imladris.surriel.com>
 <1042407845.3162.131.camel@RobsPC.RobertWilkens.com>
 <20030112214937.GM31238@vitelus.com>
 <1042409239.3162.136.camel@RobsPC.RobertWilkens.com>
 <20030112221802.GN31238@vitelus.com>
 <1042410897.1209.165.camel@RobsPC.RobertWilkens.com>
 <20030112225228.GP31238@vitelus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-01-12 at 17:52, Aaron Lehmann wrote:
> On Sun, Jan 12, 2003 at 05:34:58PM -0500, Rob Wilkens wrote:
> > You're wrong.  You wouldn't have to jump over them any more than you
> > have to jump over the "goto" statement.
> 
> The goto is a conditional jump. You propose replacing it with a
> conditional jump past the error handling code predicated on the
> opposite condition. Where's the improvement?

The goto is absolutely not a conditional jump.  The if that precedes it
is conditional.  The goto is not.  The if is already there.

-Rob

