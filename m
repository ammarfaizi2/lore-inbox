Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293495AbSBZD1L>; Mon, 25 Feb 2002 22:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293496AbSBZD1C>; Mon, 25 Feb 2002 22:27:02 -0500
Received: from dsl-65-185-109-125.telocity.com ([65.185.109.125]:56194 "EHLO
	ohdarn.net") by vger.kernel.org with ESMTP id <S293495AbSBZD0v>;
	Mon, 25 Feb 2002 22:26:51 -0500
Date: Mon, 25 Feb 2002 22:26:53 -0500
From: Michael Cohen <me@ohdarn.net>
To: Robert Love <rml@tech9.net>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
        marcelo@conectiva.com.br
Subject: Re: Submissions for 2.4.19-pre [x86 Syscall Optimizations (Alexander Khripin)]
Message-Id: <20020225222653.5d1a1d27.me@ohdarn.net>
In-Reply-To: <1014693559.883.5.camel@phantasy>
In-Reply-To: <20020225210721.2ffa8fb1.me@ohdarn.net>
	<E16fXS2-0007SP-00@the-village.bc.nu>
	<20020225213255.2b403560.me@ohdarn.net>
	<1014693559.883.5.camel@phantasy>
Organization: OhDarn.net
X-Mailer: Sylpheed version 0.7.2 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Feb 2002 22:19:17 -0500
Robert Love <rml@tech9.net> wrote:

> > See Subject ^^ Alexander Khripin.  Looks to me like it improves latency
> > quite a bit during syscalls.  I'm unable to find the exact mail but I
> > believe I was referred to this particular patch by someone on lkml.
> 
> Eh?  The patch doesn't do anything but move movl ops around.  I suspect
> the intention may to eliminate datapath stalls, which may be a fine
> micro-optimization, but I think we need some numbers first ...

UNIXbench numbers on the way :)

------
Michael Cohen
