Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262969AbVCDSEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262969AbVCDSEw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 13:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262956AbVCDSCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 13:02:42 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:40578 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262951AbVCDSCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 13:02:33 -0500
Subject: Re: [Alsa-devel] Re: intel 8x0 went silent in 2.6.11
From: Lee Revell <rlrevell@joe-job.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mark Canter <marcus@vfxcomputing.com>,
       Nish Aravamudan <nish.aravamudan@gmail.com>,
       Pierre Ossman <drzeus-list@drzeus.cx>,
       LKML <linux-kernel@vger.kernel.org>, alsa-devel@lists.sourceforge.net
In-Reply-To: <4227EE73.60803@pobox.com>
References: <4227085C.7060104@drzeus.cx>
	 <29495f1d05030309455a990c5b@mail.gmail.com>
	 <Pine.LNX.4.62.0503031342270.19015@krusty.vfxcomputing.com>
	 <1109875926.2908.26.camel@mindpipe>
	 <Pine.LNX.4.62.0503031356150.19015@krusty.vfxcomputing.com>
	 <1109876978.2908.31.camel@mindpipe>  <4227EE73.60803@pobox.com>
Content-Type: text/plain
Date: Fri, 04 Mar 2005 13:02:27 -0500
Message-Id: <1109959348.6442.3.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-04 at 00:13 -0500, Jeff Garzik wrote:
> Lee Revell wrote:
> > If you want to complain, complain to the hardware manufacturers, who
> > make devices where bit $foo means $bar in one hardware revision, and
> > $baz in the next, and don't give us sufficient documentation to sort out
> > the mess.
> 
> That's not terribly productive.
> 
> Life is what it is.  We deal with it.

That was actually my point.  I guess I could have been a bit clearer...

Anyone who works with drivers knows that hardware manufacturers will
always do things like this.  There is absolutely no point in complaining
about it, either to the vendor or on LKML.  The only fix is to file a
good bug report so it can be fixed.

Lee


