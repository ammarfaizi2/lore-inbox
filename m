Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281103AbRKDSsI>; Sun, 4 Nov 2001 13:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280423AbRKDSr6>; Sun, 4 Nov 2001 13:47:58 -0500
Received: from L0873P07.dipool.highway.telekom.at ([62.46.173.7]:19978 "EHLO
	tserver") by vger.kernel.org with ESMTP id <S281099AbRKDSrv>;
	Sun, 4 Nov 2001 13:47:51 -0500
Message-ID: <014701c16561$301266f0$0200a8c0@piii450>
Reply-To: "Tom Winkler" <tiger@tserver.2y.net>
From: "Tom Winkler" <tiger@tserver.2y.net>
To: <linux-kernel@vger.kernel.org>
Cc: <manfred@colorfullife.com>, <jgarzik@mandrakesoft.com>
In-Reply-To: <3BE5201F.78A6B811@colorfullife.com> <3BE54ADC.14A2D24C@mandrakesoft.com>
Subject: Re: Vaio IRQ routing / USB problem
Date: Sun, 4 Nov 2001 19:47:43 +0100
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

Hi,

I tested both patches from Manfred and both of them worked!
My Vaio now works perfectly with USB. I've put together some
short information at http://www.sbox.tugraz.at/home/t/twinkler/vaio/
(dmesg and interrupts - if you're interested in something else let me
know).  I'm not really sure which of the patches to use since both
are working. For now I'll stick with the first one I guess.
Just a questinon: Will this patch (wich as far as I saw on the web
will be interesting for many other vaio users) be part of one of the
next kernel releases? If you need me to test something related to
this patch just drop me a line.

Thank you very much Manfred and Jeff for your help,
    Tom

