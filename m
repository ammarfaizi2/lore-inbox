Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262416AbSJ1M2B>; Mon, 28 Oct 2002 07:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262420AbSJ1M2B>; Mon, 28 Oct 2002 07:28:01 -0500
Received: from gromit.trivadis.com ([193.73.126.130]:30351 "EHLO trivadis.com")
	by vger.kernel.org with ESMTP id <S262416AbSJ1M2A>;
	Mon, 28 Oct 2002 07:28:00 -0500
Envelope-to: linux-kernel@vger.kernel.org
Date: Mon, 28 Oct 2002 13:22:25 +0100
From: Tim Tassonis <timtas@cubic.ch>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Swap doesn't work
In-Reply-To: <1035753454.30373.33.camel@irongate.swansea.linux.org.uk>
References: <E185tHb-0002mq-00@trivadis.com>
	<1035753454.30373.33.camel@irongate.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.8.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E1868uX-0000Q8-00@trivadis.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Oct 2002 21:17:34 +0000
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Sun, 2002-10-27 at 19:41, Tim Tassonis wrote:
> > Not that I would know better or have an idea why this bug happens, but
> > to say "Bugger off if you have an lfs system" is a bit lousy, I think.
> > After all, lfs has not really an "unstrusted toolchain", as compared
> > to RH/Suse's/Debian "trustworthy computing toolchains":
> 
> I get bugs that are clearly caused by miscompiled tool chains from Linux
> from scratch people. I trust the RH, SuSE and Debian tool chains because
> they have any neccessary patches applied for compiler bugs and they are
> running against a properly built glibc and binutils.
> 
> If you simply grab the latest and greatest of everything from
> ftp.gnu.org then quite often it won't work. 

That's certainly true and before claiming a kernel bug, I would try
against a Red Hat System personally. Still, lfs does have gcc patches
included, it's not just cvs checkout from the relevant packages. It also
seems to have a sane order of compiling everything.

> If you'd like to me to spend hours debugging an LFS system where its
> probably a tool error, then you can ask for current hourly rates.

That wasn't actually my idea. And you are right, before claiming a kernel
bug one should probably always try to reproduce it against a different
system.

Bye
Tim

