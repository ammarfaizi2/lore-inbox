Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267725AbRGZK1D>; Thu, 26 Jul 2001 06:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267718AbRGZK0x>; Thu, 26 Jul 2001 06:26:53 -0400
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:40972 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S267727AbRGZK0f>; Thu, 26 Jul 2001 06:26:35 -0400
X-Apparently-From: <kiwiunixman@yahoo.co.nz>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Matthew Gardiner <kiwiunixman@yahoo.co.nz>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Unresolved symbols in 2.4.7 ppp_generic.o ?
Date: Thu, 26 Jul 2001 22:25:16 +1200
X-Mailer: KMail [version 1.2]
In-Reply-To: <20010726024450.T11246@pervalidus>
In-Reply-To: <20010726024450.T11246@pervalidus>
MIME-Version: 1.0
Message-Id: <01072622251600.00924@kiwiunixman.nodomain.nowhere>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

JUst recompiled then, and I haven't had any problems. At one stage I had alot 
of those errors, however, when I upgraded to the latest required kernel 
utils, the errors vanished, except for one (I can't remember).

Matthew Gardiner

On Thursday 26 July 2001 17:44, Frédéric L. W. Meunier wrote:
> Hi. I just built 2.4.7 (I patched 2.4.6 to 2.4.7) and doing a
> depmod noticed the following:
>
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.7/kernel/drivers/net/ppp_generic.o depmod:    slhc_init
> depmod:        slhc_free
> depmod:        slhc_uncompress
> depmod:  slhc_toss
> depmod:        slhc_remember
> depmod:    slhc_compress
>
> I don't know what's wrong because I first did a make mrproper.
>
> Maybe something was missing from patch-2.4.7.bz2 ?

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

