Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280950AbRKCNGn>; Sat, 3 Nov 2001 08:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280951AbRKCNGc>; Sat, 3 Nov 2001 08:06:32 -0500
Received: from imo-d05.mx.aol.com ([205.188.157.37]:65185 "EHLO
	imo-d05.mx.aol.com") by vger.kernel.org with ESMTP
	id <S280950AbRKCNGT>; Sat, 3 Nov 2001 08:06:19 -0500
From: Telford002@aol.com
Message-ID: <86.1204971d.291545b9@aol.com>
Date: Sat, 3 Nov 2001 08:06:01 EST
Subject: Re: [PATCH] 2.5 PROPOSAL: Replacement for current /proc of shit.
To: tim@tjansen.de, rusty@rustcorp.com.au
CC: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: AOL 5.0 for Windows sub 139
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In a message dated 11/3/01 6:47:18 AM Eastern Standard Time, tim@tjansen.de 
writes:

> On Saturday 03 November 2001 00:31, you wrote:
>  > Hmm, I'd argue that a GUI tool would be fairly useless without knowing 
> what
>  > the values meant anwyay, to give help, in which case you might as well 
> know
>  > the types.
>  
>  Take, as an example, the compression module parameter of the PWC (Philips 
>  Webcam) driver. Currently you can specify a value between 0 for 
uncompressed 
> 
>  and 3 for high compression. If a GUI shows me that only values between 0 
and 
> 
>  3 are allowed I could guess that I have to enter "3" for high compression 
>  without searching for the documentation. It would be even better if I 
could 
>  select four strings, "none", "low", "medium" and "high". 
>  
>  I do see the advantages of using strings in proc, and maybe there is 
another 
> 
>  solution: keep the type information out of the proc filesystem and save it 
>  in a file similar to Configure.help, together with a description for a 
file. 
> 
>  I just don't know how to ensure that they are in sync. 
>  
It would always be possible to build a front end to the /proc file
system.

Joachim Martillo 
