Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293468AbSBZCdN>; Mon, 25 Feb 2002 21:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293483AbSBZCdD>; Mon, 25 Feb 2002 21:33:03 -0500
Received: from dsl-65-185-109-125.telocity.com ([65.185.109.125]:50306 "EHLO
	ohdarn.net") by vger.kernel.org with ESMTP id <S293468AbSBZCcx>;
	Mon, 25 Feb 2002 21:32:53 -0500
Date: Mon, 25 Feb 2002 21:32:55 -0500
From: Michael Cohen <me@ohdarn.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: Submissions for 2.4.19-pre [x86 Syscall Optimizations (Alexander Khripin)]
Message-Id: <20020225213255.2b403560.me@ohdarn.net>
In-Reply-To: <E16fXS2-0007SP-00@the-village.bc.nu>
In-Reply-To: <20020225210721.2ffa8fb1.me@ohdarn.net>
	<E16fXS2-0007SP-00@the-village.bc.nu>
Organization: OhDarn.net
X-Mailer: Sylpheed version 0.7.2 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Feb 2002 02:34:46 +0000 (GMT)
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> > This is the sixth of several mails containing patches to be included in 2.4.19.  Some are worthy of dicussion prior to inclusion and have been marked as such.  The majority of these patches were found on lkml; the remaining ones have URLs listed.
> > This one originated on lkml.
> 
> Credit for the originator and an explanation would be helpful
See Subject ^^ Alexander Khripin.  Looks to me like it improves latency quite a bit during syscalls.  I'm unable to find the exact mail but I believe I was referred to this particular patch by someone on lkml.

------
Michael Cohen
OhDarn.net
