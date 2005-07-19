Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261594AbVGSBLg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbVGSBLg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 21:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbVGSBLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 21:11:36 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:6632 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261594AbVGSBLf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 21:11:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MFx64+Aolin3rFUCblxmBRmp1cByZn3LhDViampDxbPWTvfFz5VJXGYwM6ZJaC1lvQl53cHkMsxGpqYix2A+ToB2Z2fm0O4l7QbtfFwuoSre4X+IW5PmbxcwkoORg66TnGWbPqOdL8MHioYwcSPnr+PPeaOL6QD9R3jlFHbmYkc=
Message-ID: <9a87484905071818116f7cb0de@mail.gmail.com>
Date: Tue, 19 Jul 2005 03:11:08 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: regatta <regatta@gmail.com>
Subject: Re: how to be a kernel developer ?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5a3ed56505071807357fc419e7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5a3ed56505071807357fc419e7@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/05, regatta <regatta@gmail.com> wrote:
> Hi
> 
> I want to join the Kernel community and help in developing Linux
> kernel, I'm good in C,Perl and  not that good in C++
> 
The kernel is written in (mainly) C and (a little bit of) asm, no C++ in there.

> is there any How-To page in how to help or how to join ? since I want
> to start in basic things
> 
A few things you should do : 

- Take a look in the Documentation/ directory in the kernel source,
you'll find lots of valuable information there.

- Go check out http://kernelnewbies.org/

- You may also find this online source browser useful (I know I do)
http://lxr.linux.no/

- Keep a link to a LKML archive in your bookmarks and search the
archives for answers whenever you have a question - chances are good
that whatever you want to ask has been asked before and answered in
depth on the list, so it'll be in the archives. Here's one LKML
archive you can use, it goes back a few years :
http://www.ussg.iu.edu/hypermail/linux/kernel/

- Subscribe to LKML and start reading the some of the threads. A lot
can be learned by reading the bugreports and solutions that pop up on
the list, there are also often discussions on ideas, implementation
details, debugging etc etc that can be valuable. So join the list and
start listening :)  ohh, and do read the lists FAQ at
http://www.tux.org/lkml/

- You may also want to join the Linux Kernel Janitors
http://janitor.kernelnewbies.org/ - they have a mailing list and a
nice TODO list of things that need doing - good place to pick a small
starting project from.

- You should also, most likely, invest in a few books on the kernel
and read them. I'd recommend these two as good ones to start with :
"Linux Kernel Development (2nd Edition), by Robert Love" and "Linux
Device Drivers (Third Edition), by Jonathan Corbet, Alessandro Rubini,
and Greg Kroah-Hartman".

- And most important of all, start reading the kernel source, and play
with the kernel source. Reading the source, making some changes and
then testing them and learning from the mistakes you make is a great
way to learn.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
