Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265476AbRFVRnJ>; Fri, 22 Jun 2001 13:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265477AbRFVRm7>; Fri, 22 Jun 2001 13:42:59 -0400
Received: from chaos.analogic.com ([204.178.40.224]:8320 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265476AbRFVRmw>; Fri, 22 Jun 2001 13:42:52 -0400
Date: Fri, 22 Jun 2001 13:42:47 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Schilling, Richard" <RSchilling@affiliatedhealth.org>
cc: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: For comment: draft BIOS use document for the kernel
In-Reply-To: <51FCCCF0C130D211BE550008C724149E01165694@mail1.affiliatedhealth.org>
Message-ID: <Pine.LNX.3.95.1010622133759.3929A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jun 2001, Schilling, Richard wrote:

> 
> You've described a relatively complicated procedure well in this document.
> My only suggestion would be to reference the applicable source code files
> throughout the text, so that it's easy to find the associated code.
> 

I could not find any reference to BIOS int 0x15, function 0x87, block-
move, used to copy the kernel to above the 1 megabyte real-mode
boundary. I think this is still used.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


