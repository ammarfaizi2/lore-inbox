Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292107AbSBTRiE>; Wed, 20 Feb 2002 12:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292124AbSBTRh5>; Wed, 20 Feb 2002 12:37:57 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:47114 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292107AbSBTRhB>; Wed, 20 Feb 2002 12:37:01 -0500
Subject: Re: Please help me with newer 2.4.xx
To: riot777@skrzynka.pl (Riot777)
Date: Wed, 20 Feb 2002 17:51:04 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <000401c1ba31$082104b0$d8644cd5@krios> from "Riot777" at Feb 20, 2002 06:04:51 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16datU-0004Dq-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Driver is a closed source drv in program which is making a module cold
> sm56.o after typed command.
> Motorola says the driver is fully functional and they can't help me becouse
> company discounted from softmodem buisness. And the driver only works on
> kernels 2.4.xx .

Now you know why you should never buy a product with a binary only driver.
The only thing you can do is probably to reverse engineer and reimplement
the entire product, or convince motorola that since they are out
of the market they might care to put out the docs about it now

Alan
