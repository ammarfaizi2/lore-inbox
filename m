Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131708AbRC3XKB>; Fri, 30 Mar 2001 18:10:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131709AbRC3XJx>; Fri, 30 Mar 2001 18:09:53 -0500
Received: from venus.postmark.net ([207.244.122.71]:33554 "HELO
	venus.postmark.net") by vger.kernel.org with SMTP
	id <S131708AbRC3XJe>; Fri, 30 Mar 2001 18:09:34 -0500
Message-ID: <20010331001238.10669.qmail@venus.postmark.net>
Mime-Version: 1.0
From: J Brook <jbk@postmark.net>
To: mythos <papadako@csd.uoc.gr>, Alan Olsen <alan@clueserver.org>,
   Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Matrox G400 Dualhead
Date: Sat, 31 Mar 2001 00:12:38 +0000
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does anyone know why fualhead is not working anymore?
> I just get a screen with rubbish on the second head.
> Also when kernel loads and and registers fb1 I lose signal
> on the second head.

...

>With 2.4.2 it was working just fine. 

I have also noticed problems with the 2.4.3 release. I have a G450
32Mb, that I use in single-head mode. The console framebuffer runs
fine at boot time, but when I load X (4.0.3 compiled with Matrox HAL
library) and then return to the console, I get a blank screen (signal
lost).

I don't know what the problem is. I can confirm with Mythos that
under
2.4.2 it was working just fine :-)

Petr Vandrovec is the man who knows... what do you say Petr?!

    John
----------------
jbk@postmark.net

