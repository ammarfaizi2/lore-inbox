Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289789AbSAPA0r>; Tue, 15 Jan 2002 19:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289792AbSAPA0h>; Tue, 15 Jan 2002 19:26:37 -0500
Received: from mail1.amc.com.au ([203.15.175.2]:46596 "HELO mail1.amc.com.au")
	by vger.kernel.org with SMTP id <S289789AbSAPA01>;
	Tue, 15 Jan 2002 19:26:27 -0500
Message-Id: <5.1.0.14.0.20020116111518.023f2c00@mail.amc.localnet>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 16 Jan 2002 11:26:18 +1100
To: linux-kernel@vger.kernel.org
From: Stuart Young <sgy@amc.com.au>
Subject: Re: Removing the whitespaces??? [Was: Re: Why not "attach"
  patches?]
Cc: hps@intermeta.de
In-Reply-To: <a22gfn$c15$1@forge.intermeta.de>
In-Reply-To: <Pine.LNX.4.33.0201151448050.5892-100000@xanadu.home>
 <Pine.LNX.4.33.0201151405250.9053-100000@segfault.osdlab.org>
 <20020115151629.N11251@lynx.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:11 AM 16/01/02 +0000, Henning P. Schmiedehausen wrote:
>Patch Size (uncompressed):      17,815,166 bytes (yes this _is_ 17,4 MBytes)
>            (compressed, bzip2):  3,322,456 bytes
>
>One mega-patch to shear off about 140 KBytes from the compressed (and
>about 170 k from the unpacked (94488 vs. 94316 KBytes ) kernel source
>would (while it may be the biggest single "reduce-size-of-kernel-tree
>patch" in years :-) ) a little gross.

This 'sort' of thing would be a good idea for 2.5 IMHO (pref. asap), mainly 
to get it out of the way! It would probably be a good idea to do this on a 
tree just before it matures too (eg: when 2.5 migrates to 2.6/3.0/whatever).

The savings to other trees are probably not worth the effort involved for 
what we gain back (at the moment anyway).

You'll probably find that there are other things about that might save a 
few bytes here and there too (and at the same time might clean the code up 
a bit and make it more readable).


Stuart Young - sgy@amc.com.au
(aka Cefiar) - cefiar1@optushome.com.au

[All opinions expressed in the above message are my]
[own and not necessarily the views of my employer..]

