Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269229AbRHRWzl>; Sat, 18 Aug 2001 18:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269119AbRHRWzc>; Sat, 18 Aug 2001 18:55:32 -0400
Received: from mail.fbab.net ([212.75.83.8]:30468 "HELO mail.fbab.net")
	by vger.kernel.org with SMTP id <S269229AbRHRWzU>;
	Sat, 18 Aug 2001 18:55:20 -0400
X-Qmail-Scanner-Mail-From: mag@fbab.net via mail.fbab.net
X-Qmail-Scanner-Rcpt-To: fred@arkansaswebs.com tmh@nothing-on.tv linux-kernel@vger.kernel.org
X-Qmail-Scanner: 0.94 (No viruses found. Processed in 7.742893 secs)
Message-ID: <010d01c12839$29751370$020a0a0a@totalmef>
From: "Magnus Naeslund\(f\)" <mag@fbab.net>
To: "Fred Jackson" <fred@arkansaswebs.com>, "Tony Hoyle" <tmh@nothing-on.tv>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <01081812570001.09229@bits.linuxball> <001901c12810$97ef3a70$020a0a0a@totalmef> <3B7EB162.5070207@nothing-on.tv> <01081817401000.01028@bits.linuxball>
Subject: Re: 2.4.xx won't recompile.
Date: Sun, 19 Aug 2001 00:57:31 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Fred Jackson" <fred@arkansaswebs.com>
> OK, tried it, twice, still doesn't wan't to compile the second time.
> Followed your instructions, twice. Then I deleted the directory, 
> untarred again, reconfigured the kernel from scratch, made it the 
> first pass. then it would not recompile after I ran 'make xconfig', 
> saved, and tried to recompile with 'make install'. then I ran 'make 
> mrproper', 'make xconfig', 'make dep', make install ----- broke again 
> with the following perplexing errors.
> 
> all I can tell for sure is that the compiler doewn't seem to have a 
> definition for FASTCALL.
> 
> thank you for your input.
> 
> Fred
> 

What version gcc is that?
I think gcc 2.95.[23] or the superpatched 2.96.x is nice.
Maybe youre using egcs ?
I think that compiler is "old" from a 2.4.x (x>=6) point of view?

Magnus

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
 Programmer/Networker [|] Magnus Naeslund
 PGP Key: http://www.genline.nu/mag_pgp.txt
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


