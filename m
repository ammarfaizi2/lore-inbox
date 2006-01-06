Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751514AbWAFVtY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514AbWAFVtY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 16:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbWAFVtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 16:49:24 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:6392 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751514AbWAFVtY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 16:49:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PwmQVJqSvxd56AP31nrfCrGmeTV8owD9fM3TJht6ccgZNZ/jtsgy8QSvfr2si7Fz5KaqlgPnYUda/jPhlSKZH663h7cBlhDYLFKyMnS4Cdy/s2N49tlYpp9FprhL5la6aLd4LAzb4SsnS85RWFYy0XDNQK9FM7epDTPaQoiTMI8=
Message-ID: <5a4c581d0601061349n3a41d37ya9d33e7baa2bb0d0@mail.gmail.com>
Date: Fri, 6 Jan 2006 22:49:23 +0100
From: Alessandro Suardi <alessandro.suardi@gmail.com>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Subject: Re: 2.6.15-git2: CONFIGFS_FS shows up as M/y choice, help says "if unsure, say N"
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20060106213950.GA26581@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5a4c581d0601061310j3f4eb310o1d68c0b87c278685@mail.gmail.com>
	 <20060106213950.GA26581@csclub.uwaterloo.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/06, Lennart Sorensen <lsorense@csclub.uwaterloo.ca> wrote:
> On Fri, Jan 06, 2006 at 10:10:13PM +0100, Alessandro Suardi wrote:
> > ===========
> > Userspace-driven configuration filesystem (EXPERIMENTAL) (CONFIGFS_FS)
> > [M/y/?] (NEW)
> >
> > Both sysfs and configfs can and should exist together on the
> > same system. One is not a replacement for the other.
> >
> > If unsure, say N.
> > ===========
> >
> > I think I'll say M - for now ;)
>
> Sure, if you want to play with configfs you should.  Most users probably
> have no interest in helping develop/debug it, so the decomendation makes
> perfect sense.

[Sorry for the void message - fingers slipped]

The issue is that there is no way to follow the recommendation
 in the help text. I don't want to play with configfs, but I just can't
 select the N option - only M or Y. Hope this is clearer.

Thanks,

--alessandro

 "Somehow all you ever need is, never really quite enough, you know"

   (Bruce Springsteen - "Reno")
