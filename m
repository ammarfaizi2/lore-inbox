Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265285AbUBFCNu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 21:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265316AbUBFCNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 21:13:50 -0500
Received: from bhhdoa.org.au ([216.17.101.199]:60681 "EHLO bhhdoa.org.au")
	by vger.kernel.org with ESMTP id S265285AbUBFCNt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 21:13:49 -0500
Message-ID: <1076034783.4022fcdfd4669@vds.kolivas.org>
Date: Fri,  6 Feb 2004 13:33:03 +1100
From: Con Kolivas <kernel@kolivas.org>
To: Ryan Reich <ryanr@uchicago.edu>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       apt-drink@telefonica.net
Subject: Re: 2.6.2-ck1
References: <200402052109.24122.kernel@kolivas.org> <200402060943.40973.kernel@kolivas.org> <Pine.LNX.4.58.0402051650320.14714@ryanr.aptchi.homelinux.org> <200402060953.38015.kernel@kolivas.org> <Pine.LNX.4.58.0402051948410.1732@ryanr.aptchi.homelinux.org>
In-Reply-To: <Pine.LNX.4.58.0402051948410.1732@ryanr.aptchi.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ryan Reich <ryanr@uchicago.edu>:

> Yes, of course I should have done that.  It does seem to be the bootsplash,
> though Rafael Rodriguez disagrees.  Probably a .config difference.

Ok good. A different framebuffer driver or something could be enough to account
for it working on one config and not another. Sorry but i'm unable to debug the
bootsplash bug for you though.

Con

> On Fri, 6 Feb 2004, Con Kolivas wrote:
> 
> > On Fri, 6 Feb 2004 09:51, Ryan Reich wrote:
> > > I have only your patch and the 2.6.0-test9 (the latest on bootsplash.org
> > > thus far) bootsplash patch.  I'll send you my .config separately.
> >
> > Ok well the obvious thing to ask is can you try without the bootsplash
> patch

