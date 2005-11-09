Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030378AbVKICFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030378AbVKICFq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 21:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965227AbVKICFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 21:05:46 -0500
Received: from nproxy.gmail.com ([64.233.182.200]:50210 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965156AbVKICFp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 21:05:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tsnhKn196Dwq/ckpmRSQxJO2MJPIKyYwCUjw1NQywYjfXctpRGmNXT+mSE4pgaPQCgWBEg21dY3J4xfaAJE+pXGSCDANKcl2FF+sEWjPq4ZS/sGIJH/+yu2jtNj/11n3QI47GDL9jd1FYES/qTeaLY5evN6m1j8QHEGfZ/4N+bo=
Message-ID: <2cd57c900511081805s3d385110r@mail.gmail.com>
Date: Wed, 9 Nov 2005 10:05:43 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: Greg KH <gregkh@suse.de>
Subject: Re: Linux 2.6.14.1
Cc: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
In-Reply-To: <20051109010729.GA22439@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051109010729.GA22439@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/11/9, Greg KH <gregkh@suse.de>:
> We (the -stable team) are announcing the release of the 2.6.14.1 kernel.
>
> The diffstat and short summary of the fixes are below.
>
> I'll also be replying to this message with a copy of the patch between
> 2.6.14 and 2.6.14.1, as it is small enough to do so.
>
> The updated 2.6.14.y git tree can be found at:
>         rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/linux-2.6.14.y.git
> and can be browsed at the normal kernel.org git web browser:
>         www.kernel.org/git/


I'd appreciate it that if you would not overwrite the 2.6.14 record on
the kernel.org page, but add a new record for 2.6.14.y instead. It
would benefit others too. FYI: http://lkml.org/lkml/2005/10/9/18

It's uninteresting for people to install the stable kernel x.x.x.y
sometimes. Leave the base kernel x.x.x there would be convenient.
--
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
