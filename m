Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290156AbSAKXH6>; Fri, 11 Jan 2002 18:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290158AbSAKXHs>; Fri, 11 Jan 2002 18:07:48 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:45322 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290156AbSAKXHn>; Fri, 11 Jan 2002 18:07:43 -0500
Subject: Re: [Q] Looking for an emulation for CMOV* instructions.
To: Ronald.Wahl@informatik.tu-chemnitz.de (Ronald Wahl)
Date: Fri, 11 Jan 2002 23:19:22 +0000 (GMT)
Cc: hpj@urpla.net (Hans-Peter Jansen), alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org
In-Reply-To: <m21ygwmz5u.fsf@goliath.csn.tu-chemnitz.de> from "Ronald Wahl" at Jan 11, 2002 09:05:17 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16PAxG-0000eE-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A message occurs already: "Illegal instruction". But this is not
> really a help.

So LD_PRELOAD a library that handles it
