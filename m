Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310295AbSCABln>; Thu, 28 Feb 2002 20:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310301AbSCABhb>; Thu, 28 Feb 2002 20:37:31 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:15121 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310305AbSCABhD>; Thu, 28 Feb 2002 20:37:03 -0500
Subject: Re: Congrats Marcelo,
To: davej@suse.de (Dave Jones)
Date: Fri, 1 Mar 2002 01:51:51 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        marcelo@conectiva.com.br (Marcelo Tosatti),
        jdennis@snapserver.com (Dennis Jim),
        linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org')
In-Reply-To: <20020301020328.A7662@suse.de> from "Dave Jones" at Mar 01, 2002 02:03:28 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16gcD9-00021G-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > sensor in the machine. Once you are using ACPI though you talk to ACPI
>  > and it talks to the smbus etc and knows whats in the box
> 
>  Given the fears of what happens when you look at i2c/smbus etc
>  the wrong way, is this something we can rely on DMI tables
>  to get right ?  When they can't get cachesize info right, I begin
>  to question their ability to describe a temperature sensor.

The ones I looked at seemed credible - but yes it is an issue 8)
