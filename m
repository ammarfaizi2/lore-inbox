Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270264AbRHWVK4>; Thu, 23 Aug 2001 17:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270339AbRHWVKr>; Thu, 23 Aug 2001 17:10:47 -0400
Received: from chaos.analogic.com ([204.178.40.224]:27270 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S270264AbRHWVKe>; Thu, 23 Aug 2001 17:10:34 -0400
Date: Thu, 23 Aug 2001 17:10:17 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Bart Vandewoestyne <Bart.Vandewoestyne@pandora.be>
cc: linux-kernel@vger.kernel.org
Subject: Re: assembler -> linux system calls
In-Reply-To: <3B856E09.EAAE6564@pandora.be>
Message-ID: <Pine.LNX.3.95.1010823170837.23731A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Aug 2001, Bart Vandewoestyne wrote:

> I am trying to write a linux device driver for a data acquisition
> card.  The little homepage for my project is at
> http://mc303.ulyssis.org/heim/
> There is already a DOS driver available, and I am trying to port the
> DOS code right now.
> 
> Somewhere in the DOS code, there is some assembler code included:
[SNIPPED...]

File:
/usr/include/asm/io.h
...contains most of the I/O macros you need.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


