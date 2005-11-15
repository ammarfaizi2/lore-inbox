Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965027AbVKOUNc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965027AbVKOUNc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 15:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965028AbVKOUNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 15:13:32 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:16483 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965027AbVKOUNc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 15:13:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WUaSmm15PlIQI1x/6cTyTjYBkZO+F+YTRXK23rQUH7fdCl+IHElipLGGGeEEZ8gvonDbmYsoex3hS9Lr2TazpgueRu+M5EHIgy/RiyXvCGCshuLEx2iDbGJGtZcn4Ecns1/AKOWKsYp8vT0OsZVC77BYRudjBSUE9eibkwP9wrA=
Message-ID: <625fc13d0511151213w655bd44fp440fdafedbd1316e@mail.gmail.com>
Date: Tue, 15 Nov 2005 14:13:31 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: Luca <kronos@kronoz.cjb.net>
Subject: Re: [RFC] HOWTO do Linux kernel development
Cc: linux-kernel@vger.kernel.org, Greg KH <gregkh@suse.de>
In-Reply-To: <20051115201051.GA13473@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051114220709.GA5234@kroah.com>
	 <20051115201051.GA13473@dreamland.darkstar.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/05, Luca <kronos@kronoz.cjb.net> wrote:
> Greg KH <gregkh@suse.de> ha scritto:
> > Intro
> > -----
> [...]
> > Though they
> > are not a good substitute for a solid C education and/or years of
> > experience, the following books are good, if anything for reference:
> >
> > "The C Programming Language" by Kernighan and Ritchie [Prentice Hall]
> > "Practical C Programming" by Steve Oualline [O'Reilly]
> > "Programming the 80386" by Crawford and Gelsinger [Sybek]
> > "UNIX Systems for Modern Architectures" by Curt Schimmel [Addison Wesley]
>
> Hi Greg,
> you may want to add:
>
> "Linux Kernel Development, 2nd ed." by Robert Love [Novell Press]
> and
> "Linux Device Drivers, 3rd ed." by J. Corbet, A. Rubini and G. Kroah-Hartman [O'Reilly]
>
> IMHO the first one is a must-have for beginners who want to have an
> overall picture of the kernel and LDD is very helpful when you start doing
> some real work :)

I'll second that.

josh
