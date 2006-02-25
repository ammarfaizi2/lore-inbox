Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161047AbWBYSiT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161047AbWBYSiT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 13:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161053AbWBYSiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 13:38:19 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:32052 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161047AbWBYSiT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 13:38:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XczvflaKaz/lbh2B0YMTYveFj2akyWSz6lR3Zb+fU+CT6xWZRBHeRcH1xD+Y3hF6XTkbaoWI91JFlNrX3/qRbc04qrxCF88mn8sl32U5FaoEfNr3oLVxJXjzgKl93FgDWt65v+GUq5Opq3tSFgnb7cIW3LSHjmjlEMBrQOhaBVs=
Message-ID: <9a8748490602251038u6440e8b1t804a891bc80acdc0@mail.gmail.com>
Date: Sat, 25 Feb 2006 19:38:18 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Bernhard Rosenkraenzer" <bero@arklinux.org>, linux-kernel@vger.kernel.org
Subject: Re: [slightly OT] dvdrecord 0.3.1 -- and yes, dev=/dev/cdrom works ;)
In-Reply-To: <20060225181726.GC25076@fargo>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <200602250042.51677.bero@arklinux.org>
	 <20060225181726.GC25076@fargo>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/06, David Gómez <david@pleyades.net> wrote:
> Hi Bernard,
>
> On Feb 25 at 12:42:51, Bernhard Rosenkraenzer wrote:
> >
> > I've just released dvdrtools 0.3.1
> > (http://www.arklinux.org/projects/dvdrtools/). It is a fork of cdrtools that
> > (as the name indicates) adds support for writing to DVD-R and DVD-RW disks
> > using purely Free Software, that tries to do things the Linux way ("dvdrecord
> > dev=/dev/cdrom whatever.iso") without suggesting to use 2.4 kernels or even
> > other operating systems, uses a standard make system, is maintained in a
> > public svn repository, and does away with a lot of the libc
> > functionality-clones found in cdrtools.
>
> Good ;). This is first useful post i see since the CD recording flamewar ;).
>
I'll second that.
A very nice initiative indeed. Now lets just hope it stays maintained,
works well and that eventually distros will pick it up.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
