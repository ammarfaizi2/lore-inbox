Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273109AbRIOW1I>; Sat, 15 Sep 2001 18:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273110AbRIOW06>; Sat, 15 Sep 2001 18:26:58 -0400
Received: from [216.151.155.121] ([216.151.155.121]:45062 "EHLO
	belphigor.mcnaught.org") by vger.kernel.org with ESMTP
	id <S273109AbRIOW0u>; Sat, 15 Sep 2001 18:26:50 -0400
To: Johnny Mnemonic <johnny@themnemonic.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.4.* hangs just after uncompressing image
In-Reply-To: <5.1.0.14.2.20010915232738.00a90ba0@mail.tcsitalia.it>
From: Doug McNaught <doug@wireboard.com>
Date: 15 Sep 2001 18:27:09 -0400
In-Reply-To: Johnny Mnemonic's message of "Sat, 15 Sep 2001 23:39:57 +0200"
Message-ID: <m3y9ngdr9e.fsf@belphigor.mcnaught.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) XEmacs/21.1 (20 Minutes to Nikko)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johnny Mnemonic <johnny@themnemonic.org> writes:

> Greetings,
> I'm currently running kernel 2.2.19 fine, and I'd need to upgrade to 2.4
> shortly, but after a careful configuration when i try to boot it hangs just
> after the message "Ok, booting kernel .."

Are you perhaps compiling for a higher version of the CPU?  EG
compiling for P6 but booting on a P5?

> The cpu is a Pentium Celeron 166 with 32Mb of RAM.

Check your "CPU type" setting--I think it defaults to P6.

-Doug
-- 
In a world of steel-eyed death, and men who are fighting to be born,
Come in, she said, I'll give you shelter from the storm.    -Dylan
