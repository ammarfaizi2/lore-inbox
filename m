Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750974AbVIWSaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbVIWSaY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 14:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbVIWSaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 14:30:24 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:11868 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750974AbVIWSaY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 14:30:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gJFsTofLB6SPIFhpJ3k6306Iikz19z+Bl2KlOn8tN2lLLPqvhDFeFPiZiLOCdhH2y+vFEmdmAId+wJ6VtvuItnIZNtvvK1q5rLzUFoHVXGwcYTFVZ7s9atuHPGxlGM4AS1HZ+YdHSUNvGIWj3l55KJk3b9dYGQB1g+x2gA9goJ8=
Message-ID: <1e62d13705092311306853e7d0@mail.gmail.com>
Date: Fri, 23 Sep 2005 23:30:22 +0500
From: Fawad Lateef <fawadlateef@gmail.com>
Reply-To: Fawad Lateef <fawadlateef@gmail.com>
To: Jens Axboe <axboe@suse.de>
Subject: Re: Trapping Block I/O
Cc: Block Device <blockdevice@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20050923181435.GI22655@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <64c7635405092305433356bd17@mail.gmail.com>
	 <1e62d137050923103843058e92@mail.gmail.com>
	 <20050923180407.GG22655@suse.de>
	 <1e62d137050923111046d0b762@mail.gmail.com>
	 <20050923181435.GI22655@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/05, Jens Axboe <axboe@suse.de> wrote:
> Well it's pretty new, so no wonder. But it should do everything you want
> and lots more. There's a list for it here:
>
> linux-btrace@vger.kernel.org
>
> I'm a little pressed for time these days, but I'll do a proper announce
> / demo of all the features starting next week since it's basically
> feature complete now.
>
> If you don't use git, there are also snapshots available on kernel.org,
> more precisely here:
>
> kernel.org/pub/linux/kernel/people/axboe/blktrace/
>
> but kernel.org is pretty slow these days, so pulling from the git repo
> above is greatly recommended.
>

Ya, I looked at it and its looking very good tool to tracing block I/O
layer, but this tracing requires recompilation of the kernel and have
to use on kernel directly from kernel.org but its not a big deal, I
hope it will get into the main kernel soon ....

By the way my approach about creating wrapper and getting the device
requests without modification into the kernel and can be easily used
on any block device ...... ;)


--
Fawad Lateef
