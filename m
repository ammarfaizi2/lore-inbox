Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276091AbRI1Ows>; Fri, 28 Sep 2001 10:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276090AbRI1Ow2>; Fri, 28 Sep 2001 10:52:28 -0400
Received: from femail37.sdc1.sfba.home.com ([24.254.60.31]:23292 "EHLO
	femail37.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S276088AbRI1OwW>; Fri, 28 Sep 2001 10:52:22 -0400
Content-Type: text/plain; charset=US-ASCII
From: Nicholas Knight <tegeran@home.com>
Reply-To: tegeran@home.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, arjanv@redhat.com
Subject: Re: Binary only module overview
Date: Fri, 28 Sep 2001 07:52:48 -0700
X-Mailer: KMail [version 1.3.1]
Cc: segfault@club-internet.fr (Daniel Caujolle-Bert),
        linux-kernel@vger.kernel.org
In-Reply-To: <E15myqL-0007E8-00@the-village.bc.nu>
In-Reply-To: <E15myqL-0007E8-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010928145243.XVTG10339.femail37.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 September 2001 07:42 am, Alan Cox wrote:
> > That I would call an obvious GPL violation... no discussion
> > about vague "interfaces", if you directly link serial.c
> > (even modified) into a non-GPL .o file that's obvious....
>
> I raised this one with Ted T'so (who wrote the serial.c they use) a
> long time ago. Ted seemed happy for this to occur - and its kind of
> his code, his business.

Prehaps it'd be a good idea to (unofficialy) ask authors of drivers in 
the kernel that are thought to be GPL'd and not known to be under other 
licenses (BSD etc.), to (when possible) let the public know that 
they've granted some sort of license to a company/person to use that 
code in a binary-only module, so that people don't start accusing 
people of blatant GPL violations if they happen to notice. serial.c 
would be a perfect example of something that could be construed as a 
blatant violation and people might start yelling at the company and 
others about it, and it might make the company less willing to support 
Linux *at all*.

I'd prefer that there was no such thing as a binary-only module, but 
IMO binary-only is better than no support whatsoever. And if people 
start yelling at companies for using something they may have a 
legitimate license for, those companies may wonder what the point is in 
supporting Linux at all.

(This isn't directed at Arjan van de Ven, he just stated obvious facts, 
he didn't go off half-cocked at anybody :)
