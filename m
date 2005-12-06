Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964934AbVLFJiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964934AbVLFJiY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 04:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964936AbVLFJiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 04:38:23 -0500
Received: from ns.firmix.at ([62.141.48.66]:20382 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S964934AbVLFJiX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 04:38:23 -0500
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
From: Bernd Petrovitsch <bernd@firmix.at>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Matthias Andree <matthias.andree@gmx.de>, linux-kernel@vger.kernel.org
In-Reply-To: <200512060041.jB60fElI003764@pincoya.inf.utfsm.cl>
References: <200512060041.jB60fElI003764@pincoya.inf.utfsm.cl>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Tue, 06 Dec 2005 10:38:10 +0100
Message-Id: <1133861890.10158.46.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-05 at 21:41 -0300, Horst von Brand wrote:
> Bernd Petrovitsch <bernd@firmix.at> wrote:
[...]
[...]
> > > whole libc -> glib switchover.

Ah, that should have read "libc.5(*) to glibc" switchover"?
(*) IIRC.

> > glib has AFAIK next to nothing to do with a libc AFAICT (i.e. it is
> > using standard libc functions but that's all).
> 
> He refers to the a.out to ELF switchover. Yes, it was painful. But not as

Was it? And it was ages ago (i can't even remember since when I disable
a.out in the kernel completely and never had a problem with it).

> much as he makes out. The Win98 --> WinNT change was worse, IMHO.

Of course. Especially if you started to use the permission system and
not let the NT installation stay in the default mode where every user
may do everything everywhere (and they are hiding the contents of
certain directories in the file browser instead of simply letting the
administrator change it's contents so that folks really learn it).

[....]
> > >                                                                 The
> > > reason - infighting and lack of backwards 
> 
> > Yes, probably - MSFT is spreading the same story since ages.
> 
> Gandhi-con 3 ;-)

???? Sorry, what do you mean?

[...]
> > As other told there never was a stable kernel module interface. Of
> > course there is probably enough willing manpower out there who will work
> > on that once you pay them. Or you can provide such support on your own.
> 
> Right.
> 
> > Or do you (or anybody else) has drivers which should be maintained for
> > vanilla-kernel and/or vendor kernels and/or other kernels (to fix the
> > breakage in a cosntructive way), we can provide you with an offer to do
> > that.
> 
> Constructive criticism? Even of the sort that contributes something? What

No, since we interface here with the commercial world , it is a
commercial offer (well, sort of - at least a an offer to provide an
offer it the details and requirements are defined/clear).

> are you thinking about?!

$COMPANY wants a maintained "open" driver (probably GPL but that's not
the point)?
$COMPANY gives us money (a to be defined amount of money for a to be
defined time, for to be defined distributions and/or kernel trees, to be
defined QA with respect to the hardware driven by the driver, etc.) and
we do that for you.

Feel free to ignore it ....
	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

