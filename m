Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314602AbSEKIsk>; Sat, 11 May 2002 04:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314613AbSEKIsj>; Sat, 11 May 2002 04:48:39 -0400
Received: from m206-234.dsl.tsoft.com ([198.144.206.234]:5800 "EHLO
	jojda.2y.net") by vger.kernel.org with ESMTP id <S314602AbSEKIsi>;
	Sat, 11 May 2002 04:48:38 -0400
Message-ID: <3CDCDAE6.CB851FB6@bigfoot.com>
Date: Sat, 11 May 2002 01:48:38 -0700
From: Erik Steffl <steffl@bigfoot.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en, sk, ru
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: lost interrupt hell - Plea for Help
In-Reply-To: <Pine.LNX.3.96.1020509132713.1987A-100000@pioneer> <200205101112.g4ABCoX29098@Port.imtp.ilyichevsk.odessa.ua> <3CDC3B90.AADE1835@bigfoot.com> <3CDCD708.6000208@notnowlewis.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mikeH wrote:
> 
> You can try compiling without VIA chipset support, but it makes no
> difference.
> Now, with the latest prepatches, -ac patches and ide patches, I am
> getting spurious  "8259A interrupt: IRQ7."
> all over the place too. Seems like the linux kernel does not play well
> with AMD Cpus + VIA chipsets, which
> is a real shame as thats what all my machines are :(

  FWIW I have intel processor. It seems like the 'lost interrupt' while
ripping audio CDs is specific to VIA based motherboards.

	erik

> 
> mikeH
> 
> Erik Steffl wrote:
> 
> >  this is with stable kernel (I tried 2.4.17 and 2.4.18), via config
> >option compiled in (I haven't tried without via support in kernel yet,
> >I'll try that).
> >
> >  any ideas? TIA
> >
> >       erik
