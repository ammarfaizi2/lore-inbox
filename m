Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268297AbUIBM6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268297AbUIBM6L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 08:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268296AbUIBM6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 08:58:11 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:65449 "HELO ithnet.com")
	by vger.kernel.org with SMTP id S268297AbUIBM6G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 08:58:06 -0400
X-Sender-Authentication: net64
Date: Thu, 2 Sep 2004 14:58:04 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Frank van Maarseveen <frankvm@xs4all.nl>
Cc: torvalds@osdl.org, kangur@polcom.net, linux-kernel@vger.kernel.org
Subject: Re: silent semantic changes with reiser4
Message-Id: <20040902145804.796e561d.skraw@ithnet.com>
In-Reply-To: <20040902112623.GA3059@janus>
References: <20040829150231.GE9471@alias>
	<4132205A.9080505@namesys.com>
	<20040829183629.GP21964@parcelfarce.linux.theplanet.co.uk>
	<20040829185744.GQ21964@parcelfarce.linux.theplanet.co.uk>
	<41323751.5000607@namesys.com>
	<20040829212700.GA16297@parcelfarce.linux.theplanet.co.uk>
	<Pine.LNX.4.58.0408291431070.2295@ppc970.osdl.org>
	<Pine.LNX.4.60.0408300009001.10533@alpha.polcom.net>
	<Pine.LNX.4.58.0408291523130.2295@ppc970.osdl.org>
	<20040902125156.2dc6fe97.skraw@ithnet.com>
	<20040902112623.GA3059@janus>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Sep 2004 13:26:23 +0200
Frank van Maarseveen <frankvm@xs4all.nl> wrote:

> On Thu, Sep 02, 2004 at 12:51:56PM +0200, Stephan von Krawczynski wrote:
> > 
> > I therefore declare as this years hot issue:
> > How to use more than 32 GIDs on nfs? Frank van Maarseveens' patch being
>                        ^^
> The limit for NFS is 16.

Yes, of course. Sorry for that exaggeration ;-)

> > available for years I guess, but with 2.6 supporting lots of GIDs becoming
> > very actual...
> 
> thank you for reminding me that I still need to port it to 2.6. The patch
> came into existence around 2.2.17 IIRC.

Oh it will be very welcome once your done, the only way to circumvent the
situation currently is to give world-rights, which is of course _bad_.

Thanks in advance for this patch,
Stephan
