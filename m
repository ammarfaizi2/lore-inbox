Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964811AbVLEVlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbVLEVlL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 16:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbVLEVlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 16:41:11 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:16406 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964809AbVLEVlJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 16:41:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jPird+GL/vVq0/VKGuBQu7HvZTchJKySGpmhEZQkA8vPf0Hjr/k9gLsdNdeqd2SCZnD+MbCA5YeU2q9p8LbyKxz4FvWhD/Xr31EnY5OzY88K5WcN+lt/qMF3elnKjVhs5JcDcsG/Sv5YMKXW8CPAAW1lI8s6wVLHQDLOToPd7XQ=
Message-ID: <d120d5000512051341i3857e598n85a7131e69b93473@mail.gmail.com>
Date: Mon, 5 Dec 2005 16:41:08 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Greg KH <greg@kroah.com>
Subject: Re: Golden rule: don't break userland (was Re: RFC: Starting a stable kernel series off the 2.6 kernel)
Cc: Jeff Garzik <jgarzik@pobox.com>, Adrian Bunk <bunk@stusta.de>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>,
       James Bottomley <James.Bottomley@steeleye.com>
In-Reply-To: <20051204232903.GH8914@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051203135608.GJ31395@stusta.de> <4391E764.7050704@pobox.com>
	 <20051203203418.GA4283@kroah.com>
	 <200512032041.00594.dtor_core@ameritech.net>
	 <20051204232903.GH8914@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/05, Greg KH <greg@kroah.com> wrote:
> On Sat, Dec 03, 2005 at 08:40:59PM -0500, Dmitry Torokhov wrote:
> > On Saturday 03 December 2005 15:34, Greg KH wrote:
> > > And in the future, the driver/class model changes we are going to be
> > > doing (see http://lwn.net/Articles/162242/ for more details on this),
> > > will be going to great lengths to prevent anything in userspace from
> > > breaking.
> >
> > It is usually considered a bad netiquette to cross-post in public and
> > subscription-only lists. I wonder if pointing to subscription-only
> > service to get the feeling about planned driver core changes is a good
> > idea.
>
> My apologies.  It is merely a detailed description of what I wrote up
> here:
>        http://www.kroah.com/log/linux/driver_model_changes.html
>

Ahh, I see.

> I'll forward you a link to it off-list in a minute (and to anyone else
> who wants it.)  After a week, lwn.net is free, so it will be public.
>

That is allright, the link above is all I needed. I don't really want
to use LWN "ahead of time" - they sell subsciptions - good for them.

--
Dmitry
