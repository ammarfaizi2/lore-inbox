Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293493AbSBZC2D>; Mon, 25 Feb 2002 21:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293495AbSBZC1n>; Mon, 25 Feb 2002 21:27:43 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:47369 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293493AbSBZC1h>; Mon, 25 Feb 2002 21:27:37 -0500
Subject: Re: [DRIVER][RFC] SC1200 Watchdog driver
To: wingel@acolyte.hack.org (Christer Weinigel)
Date: Tue, 26 Feb 2002 02:42:17 +0000 (GMT)
Cc: marcelo@conectiva.com.br (Marcelo Tosatti), linux-kernel@vger.kernel.org
In-Reply-To: <20020226013735.0D309F5B@acolyte.hack.org> from "Christer Weinigel" at Feb 26, 2002 02:37:35 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16fXZK-0007UM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +The ioctl API:
> +
> +Some drivers also support an ioctl API.  I belive this API was first
> +used in the Berkshire PC Watchdog driver and has been adopted by the
> +other drivers.  

The original API is from the WDT500/501, whic first added watchdogs, and
then expanded on in the existing watchdog documentation including
the Docbook 'how to write one' manual

