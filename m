Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263807AbTI2SES (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 14:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264110AbTI2SCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 14:02:32 -0400
Received: from lucidpixels.com ([66.45.37.187]:26546 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S264109AbTI2SAI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 14:00:08 -0400
Date: Mon, 29 Sep 2003 14:00:06 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.22 ide-scsi problem.
In-Reply-To: <Pine.LNX.4.44.0309271338590.2874-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0309291359110.11560@p500>
References: <Pine.LNX.4.44.0309271338590.2874-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, similiar to a buffer underrun, I thought it was the media at first,
but after 4-6 cds, it seems like it is the kernel.

I am going to do some more testing with 2.4.21, more burns with current
media I am using to make fully sure it is or is not the kernel.


On Mon, 29 Sep 2003, Marcelo Tosatti wrote:

>
> What do you mean with "barf" ?
>
> You get IO errors?
>
> On Tue, 23 Sep 2003, Justin Piszcz wrote:
>
> > While executing two parallel burns, when one goes to finalize the disc,
> > the other one barfs (each drive = Plextor 12/10/32a (buffer underrun
> > protection)).
> >
> > This has never occured with 2.4.[0-21].
> >
> > What happened in 2.4.22 with IDE-SCSI/IDE stuff?
> >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>
>
>
