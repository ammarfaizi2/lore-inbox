Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbVJCCKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbVJCCKa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 22:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbVJCCKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 22:10:30 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:9123 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932126AbVJCCK3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 22:10:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RdiSVVu1n3IvL7zyVUiJwMz3SPgWNgB8MVDglGzarg9twOvygm8DgsiOa626wf0SOYFIJLfsVf7wkxY6i2s8W204Va2jh3bMrbPPEmVSZzAAwYI7qjHf+g2d4hhNp2bA0O8hUh8GyV+aN9eEK6j5oTimcLnsdX1krm+Ejb8zIM8=
Message-ID: <35fb2e590510021910t49980f4t9bd29201dc90be05@mail.gmail.com>
Date: Mon, 3 Oct 2005 03:10:28 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Marc Singer <elf@buici.com>
Subject: Re: Discontiguous memory fun
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20051002235512.GA15138@buici.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <35fb2e5905090110171aa77266@mail.gmail.com>
	 <35fb2e590510021157l63f6a270l2810659427a8fa9e@mail.gmail.com>
	 <20051002235512.GA15138@buici.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/05, Marc Singer <elf@buici.com> wrote:

> On Sun, Oct 02, 2005 at 07:57:30PM +0100, Jon Masters wrote:
> > Replying to my own post...
> >
> > On 9/1/05, Jon Masters <jonmasters@gmail.com> wrote:
> >
> > I'd love to know what the state of discontig memory is like on 2.6
> > series ARM kernels and highmem too for that matter, but I've not had
> > chance to look at it (I'm usually a ppc guy).
>
> It works fine.
>
> The node mapping is performed by macros in asm-arm/arch-*/memory.h.

Hmmm...as it was in 2.4. I'll take a look for my general interest.

Jon.
