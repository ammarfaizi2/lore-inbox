Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292395AbSB0O2n>; Wed, 27 Feb 2002 09:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292399AbSB0O2c>; Wed, 27 Feb 2002 09:28:32 -0500
Received: from chaos.analogic.com ([204.178.40.224]:23180 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S292511AbSB0O2I>; Wed, 27 Feb 2002 09:28:08 -0500
Date: Wed, 27 Feb 2002 09:29:58 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Jesper Juhl <jju@dif.dk>
cc: barubary@cox.net, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: ISO9660 bug and loopback driver bug - a bigger problem then it would appear?
In-Reply-To: <3C7C1797.7050604@dif.dk>
Message-ID: <Pine.LNX.3.95.1020227092650.12981A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Feb 2002, Jesper Juhl wrote:
[SNIPPED year 2100 "bug"]
[SNIPPED year 2100 "bug" --fix!]

> 
> If the above is indeed correct, wouldn't it then be better to just do 
> those changes in 2.5.x instead of 2.4.x (and then maybe backport them 
> later)...

I suggest the changes wait until Version 99.99.  Many of the File Systems
affected won't even exist 98 years from now -and an 'int' will probably
be 256 bits.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

        111,111,111 * 111,111,111 = 12,345,678,987,654,321

