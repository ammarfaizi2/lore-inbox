Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310196AbSB1XxM>; Thu, 28 Feb 2002 18:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293132AbSB1XvK>; Thu, 28 Feb 2002 18:51:10 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:63759 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310208AbSB1XrL>; Thu, 28 Feb 2002 18:47:11 -0500
Subject: Re: Congrats Marcelo,
To: marcelo@conectiva.com.br (Marcelo Tosatti)
Date: Fri, 1 Mar 2002 00:01:51 +0000 (GMT)
Cc: jdennis@snapserver.com (Dennis Jim),
        linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org')
In-Reply-To: <Pine.LNX.4.21.0202281849450.2391-100000@freak.distro.conectiva> from "Marcelo Tosatti" at Feb 28, 2002 06:52:25 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16gaUh-0001bB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 	i2c
> > 	Crypto
> > 	FreeS/WAN KLIPS
> > 	LIDS
> 
> I think its not possible to distribute crypto stuff in the stock kernel.
> Am I wrong? 

It gets hairy. There are some jurisdictions where life is a lot easier
if its seperate. 

> > have they
> >  submitted those to you for integration into 2.4.19?
> 
> Nope. I could well integrate lm_sensors in the future.

Please be careful. lm_sensors can destroy machines if configured wrongly.
Thats something that needs tackling - and ironically ACPI may actually
solve that problem
