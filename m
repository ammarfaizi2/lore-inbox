Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291605AbSBTCA6>; Tue, 19 Feb 2002 21:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291604AbSBTCAs>; Tue, 19 Feb 2002 21:00:48 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:42245 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291597AbSBTCAh>; Tue, 19 Feb 2002 21:00:37 -0500
Subject: Re: sis_malloc / sis_free
To: sartre@linuxbr.com (Jean Paul Sartre)
Date: Wed, 20 Feb 2002 02:14:30 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <Pine.LNX.4.40.0202192238350.13176-100000@sartre.linuxbr.com> from "Jean Paul Sartre" at Feb 19, 2002 10:40:00 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16dMH8-0002HL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > SIS DRM requires the SIS frame buffer.
> 
> 	But this is a 'semantic' mode of requiring. The 'requirement' does
> not apply in the source, as I saw (or it'd compile normally with the DRM
> code, and FB code gives sis_malloc and sis_free (try grepping sis_malloc

Compiles fine for me. 2.4.18rc2-ac1 - and the SiS DRM works too tho on
an old 6326 its not rocket speed.

Alan
