Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314597AbSEKInh>; Sat, 11 May 2002 04:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314600AbSEKIng>; Sat, 11 May 2002 04:43:36 -0400
Received: from smtp3.wanadoo.nl ([194.134.35.186]:39590 "EHLO smtp3.wanadoo.nl")
	by vger.kernel.org with ESMTP id <S314597AbSEKIng>;
	Sat, 11 May 2002 04:43:36 -0400
Message-Id: <4.1.20020511103241.00914250@pop.cablewanadoo.nl>
X-Mailer: QUALCOMM Windows Eudora Pro Version 4.1
Date: Sat, 11 May 2002 10:38:23 +0200
To: mikeH <mikeH@notnowlewis.co.uk>, Erik Steffl <steffl@bigfoot.com>
From: Rudmer van Dijk <rudmer@legolas.dynup.net>
Subject: Re: lost interrupt hell - Plea for Help
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3CDCD708.6000208@notnowlewis.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:32 11-5-02 +0100, mikeH wrote:
>
>You can try compiling without VIA chipset support, but it makes no 
>difference.
>Now, with the latest prepatches, -ac patches and ide patches, I am 
>getting spurious  "8259A interrupt: IRQ7."
>all over the place too. Seems like the linux kernel does not play well 
>with AMD Cpus + VIA chipsets, which
>is a real shame as thats what all my machines are :(

It's not only with VIA chipsets, I have an Athlon system with a SIS chipset
and there I get the spurious  "8259A interrupt: IRQ7." as well...
luckily the message is only displayed once, but it always appears in the
first 15 min after startup.

	Rudmer

