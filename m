Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263413AbTIHWhr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 18:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263622AbTIHWhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 18:37:47 -0400
Received: from conure.mail.pas.earthlink.net ([207.217.120.54]:63874 "EHLO
	conure.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S263413AbTIHWhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 18:37:45 -0400
Message-ID: <043301c37659$d0074490$2eedfea9@kittycat>
From: "jdow" <jdow@earthlink.net>
To: "Greg KH" <greg@kroah.com>, "Robert P. J. Day" <rpjday@mindspring.com>
Cc: "Linux kernel mailing list" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0309081137260.15517-100000@localhost.localdomain> <20030908221102.GA2953@kroah.com>
Subject: Re: problem with "Gadget filesystem" config prompt (bk10)
Date: Mon, 8 Sep 2003 15:37:40 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Greg KH" <greg@kroah.com> Monday, 2003 September, 08 15:11

> On Mon, Sep 08, 2003 at 11:40:46AM -0400, Robert P. J. Day wrote:
> >
> >   just doing a "make oldconfig", from bk9 -> bk10, being prompted for
the
> > USB_GADGETFS (Gadget filesystem), which asks
> >
> >   ... [N/m/?]  (NEW)
> >
> > without thinking, i typed "y" (not noticing that that was not a valid
> > answer), and what i got back was:
> >
> > Say "y" to link the driver statically, or "m" to build a
> > dynamically linked module called "gadgetfs".
> >
> >   which suggests that "y" *is* a valid response (when clearly it isn't).
> > someone might want to clarify this.
>
> You got the help information for this option.  And "y" is a valid option
> if one of the parent options is selected as "y".  Not much you can do
> here...

Perhaps the incorrect prompt could be fixed?

{^_-}

