Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265316AbUBFCPm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 21:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265319AbUBFCPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 21:15:42 -0500
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:51803 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265316AbUBFCPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 21:15:40 -0500
Date: Thu, 5 Feb 2004 20:15:37 -0600 (CST)
From: Ryan Reich <ryanr@uchicago.edu>
Reply-To: Ryan Reich <ryanr@uchicago.edu>
To: Con Kolivas <kernel@kolivas.org>
cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       apt-drink@telefonica.net
Subject: Re: 2.6.2-ck1
In-Reply-To: <1076034783.4022fcdfd4669@vds.kolivas.org>
Message-ID: <Pine.LNX.4.58.0402052015160.1758@ryanr.aptchi.homelinux.org>
References: <200402052109.24122.kernel@kolivas.org> <200402060943.40973.kernel@kolivas.org>
 <Pine.LNX.4.58.0402051650320.14714@ryanr.aptchi.homelinux.org>
 <200402060953.38015.kernel@kolivas.org> <Pine.LNX.4.58.0402051948410.1732@ryanr.aptchi.homelinux.org>
 <1076034783.4022fcdfd4669@vds.kolivas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Should I send this on to someone else, then?

-- 
Ryan Reich
ryanr@uchicago.edu

On Fri, 6 Feb 2004, Con Kolivas wrote:

> Quoting Ryan Reich <ryanr@uchicago.edu>:
>
> > Yes, of course I should have done that.  It does seem to be the bootsplash,
> > though Rafael Rodriguez disagrees.  Probably a .config difference.
>
> Ok good. A different framebuffer driver or something could be enough to account
> for it working on one config and not another. Sorry but i'm unable to debug the
> bootsplash bug for you though.
>
> Con
>
> > On Fri, 6 Feb 2004, Con Kolivas wrote:
> >
> > > On Fri, 6 Feb 2004 09:51, Ryan Reich wrote:
> > > > I have only your patch and the 2.6.0-test9 (the latest on bootsplash.org
> > > > thus far) bootsplash patch.  I'll send you my .config separately.
> > >
> > > Ok well the obvious thing to ask is can you try without the bootsplash
> > patch
>
