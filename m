Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261798AbSIXWjF>; Tue, 24 Sep 2002 18:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261837AbSIXWjF>; Tue, 24 Sep 2002 18:39:05 -0400
Received: from u212-239-129-204.dialup.planetinternet.be ([212.239.129.204]:9732
	"EHLO jebril.pi.be") by vger.kernel.org with ESMTP
	id <S261798AbSIXWjF>; Tue, 24 Sep 2002 18:39:05 -0400
Message-Id: <200209242242.g8OMgmvX008154@jebril.pi.be>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.38 
In-Reply-To: Your message of "Mon, 23 Sep 2002 16:23:56 PDT."
             <Pine.LNX.4.33.0209231621580.2662-100000@penguin.transmeta.com> 
Date: Wed, 25 Sep 2002 00:42:48 +0200
From: "Michel Eyckmans (MCE)" <mce@pi.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Anyway, I'd really like to pinpoint that by having you try another mouse 
> (borrow a PS/2 or USB mouse from somebody), to make sure that it really is 
> mouse-related.. After that I can try to beat up on Vojtech.

I'd like to test other mice too, but I have nowhere to connect them to. 
This box is 6 years old by now (and yet still going strong :-), so it
doesn't have all those post-modern connectors...

For completeness: very occasionally, X does survive an hour or so of
normal use. So much so that last night I even thought to have found a 
solution by changing a mouse-related bit in my kernel config. But today
it locked up again, causing me to loose a whole bunch of mails in the 
process. So I'm back to 2.5.31 once more.

I'm gonna try a non-smp 2.5.38 next, to see if that makes any difference.

MCE
