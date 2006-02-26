Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbWBZNgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbWBZNgf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 08:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbWBZNgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 08:36:35 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:57012 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751125AbWBZNge convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 08:36:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VRjOmVZZ4rjWZSbqm6JbSAJSdYxjPJvipAz1LF5BeiEq7r5++6v84nOyaGIHxU32MecsG/TiawhRNuon7JnFx0Y+Lq55qs93CPnpaQPV0pI7E8+9HcJhEz83llegYRfroGjVeouuxHm9f74rktd0umBCQaOgJ4unRJXU2i0uCqk=
Message-ID: <9a8748490602260536v22cc4dc0ma4e2702cd064e5c0@mail.gmail.com>
Date: Sun, 26 Feb 2006 14:36:31 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: Luke-Jr <luke@dashjr.org>
Subject: Re: [slightly OT] dvdrecord 0.3.1 -- and yes, dev=/dev/cdrom works ;)
Cc: "Bernhard Rosenkraenzer" <bero@arklinux.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200602261339.13821.luke@dashjr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200602250042.51677.bero@arklinux.org>
	 <200602261330.15709.luke@dashjr.org>
	 <9a8748490602260529h3a2890bhce4112feefb7cb1f@mail.gmail.com>
	 <200602261339.13821.luke@dashjr.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/06, Luke-Jr <luke@dashjr.org> wrote:
> On Sunday 26 February 2006 13:29, Jesper Juhl wrote:
> > On 2/26/06, Luke-Jr <luke@dashjr.org> wrote:
> > > On Friday 24 February 2006 23:42, Bernhard Rosenkraenzer wrote:
> > > > I've just released dvdrtools 0.3.1
> > > > (http://www.arklinux.org/projects/dvdrtools/). It is a fork of cdrtools
> > > > that (as the name indicates) adds support for writing to DVD-R and
> > > > DVD-RW disks using purely Free Software,
> > >
> > > also DVD+R/RW/DL, I hope?
> >
> > And what about DVD-RAM drives? Any plans to support those?
>
> My [limited] understanding of DVD-RAM drives was that they are basically
> removable block devices... you wouldn't need a recording program for that,
> you'd use it like a floppy.
>
I guess you are right. I haven't used a DVD-RAM device in a few years,
I just seem to recall that when I last used one on an AIX pSeries
machine I had to use some burner software to dump data on it - I may
remember wrong though.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
