Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269786AbRHSAwK>; Sat, 18 Aug 2001 20:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269801AbRHSAvv>; Sat, 18 Aug 2001 20:51:51 -0400
Received: from [209.38.98.99] ([209.38.98.99]:45785 "EHLO srvr201.castmark.com")
	by vger.kernel.org with ESMTP id <S269786AbRHSAvn>;
	Sat, 18 Aug 2001 20:51:43 -0400
Content-Type: text/plain; charset=US-ASCII
From: Fred Jackson <fred@arkansaswebs.com>
To: mag@fbab.net, "Tony Hoyle" <tmh@nothing-on.tv>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.xx won't recompile.
Date: Sat, 18 Aug 2001 19:49:58 -0500
X-Mailer: KMail [version 1.2]
In-Reply-To: <01081812570001.09229@bits.linuxball> <01081817401000.01028@bits.linuxball> <010d01c12839$29751370$020a0a0a@totalmef>
In-Reply-To: <010d01c12839$29751370$020a0a0a@totalmef>
Cc: =?iso-8859-1?q?Andr=E9=20Dahlqvist?= <andre.dahlqvist@telia.com>
MIME-Version: 1.0
Message-Id: <01081819495801.01028@bits.linuxball>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm using:

gcc-2.96-81  (redhat 7.1)

no egcs installed ??

I kinda figured that redhat would install the tools for a kernel 
compile. and what is  compat-egcs-6.2-1.1.2.14 that is shipped with 
redhat?

thanks 

Fred



_________________________________ 
On Saturday 18 August 2001 05:57 pm, Magnus Naeslund\(f\) wrote:
> From: "Fred Jackson" <fred@arkansaswebs.com>
> > OK, tried it, twice, still doesn't wan't to compile the second 
time.
> > Followed your instructions, twice. Then I deleted the directory, 
> > untarred again, reconfigured the kernel from scratch, made it the 
> > first pass. then it would not recompile after I ran 'make 
xconfig', 
> > saved, and tried to recompile with 'make install'. then I ran 
'make 
> > mrproper', 'make xconfig', 'make dep', make install ----- broke 
again 
> > with the following perplexing errors.
> > 
> > all I can tell for sure is that the compiler doewn't seem to have 
a 
> > definition for FASTCALL.
> > 
> > thank you for your input.
> > 
> > Fred
> > 
> 
> What version gcc is that?
> I think gcc 2.95.[23] or the superpatched 2.96.x is nice.
> Maybe youre using egcs ?
> I think that compiler is "old" from a 2.4.x (x>=6) point of view?
> 
> Magnus
> 
> -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
>  Programmer/Networker [|] Magnus Naeslund
>  PGP Key: http://www.genline.nu/mag_pgp.txt
> -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
> 
> 
