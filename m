Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265701AbRFXBn5>; Sat, 23 Jun 2001 21:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265699AbRFXBnr>; Sat, 23 Jun 2001 21:43:47 -0400
Received: from chaos.analogic.com ([204.178.40.224]:62848 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265700AbRFXBnd>; Sat, 23 Jun 2001 21:43:33 -0400
Date: Sat, 23 Jun 2001 21:43:05 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Wan Hing Wah <50191914@uxmail.cityu.edu.hk>
cc: linux-kernel@vger.kernel.org
Subject: Re: GPIB support
In-Reply-To: <Pine.GSO.4.33.0106231213430.19291-100000@moscow>
Message-ID: <Pine.LNX.3.95.1010623213228.21862A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Jun 2001, Wan Hing Wah wrote:

> I'm doing a project which port a component testing program in DOS which
> use GPIB to linux
> Does the Linux kernel support GPIB?
> 
> 
> I find a linux gpib driver in the  linux lab project
> http://www.llp.fu-berlin.de/
> 

GPIB is terribly device-specific. What board do you intend to use?
National Instruments has a so-called driver for their TNT4882 on
their web-site. I was never able to get it to even compile, much
less work.

I have a driver written for that chip. It's not GPLed, but it
could be if there is enough interest. In any event, I could send
you the source to try out. Just don't publish it yet. Let me
know because I could use additional input for testing. In other
words, if asked, I would just say that you are helping to test
a driver...

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


