Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288051AbSBRV7Z>; Mon, 18 Feb 2002 16:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288047AbSBRV7O>; Mon, 18 Feb 2002 16:59:14 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:9 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288040AbSBRV7F>; Mon, 18 Feb 2002 16:59:05 -0500
Subject: Re: time goes backwards periodically on laptop if booted in low-power
To: dank@kegel.com (Dan Kegel)
Date: Mon, 18 Feb 2002 22:12:45 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        ncw@axis.demon.co.uk (Nick Craig-Wood),
        linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <3C717894.281D0BB4@kegel.com> from "Dan Kegel" at Feb 18, 2002 01:56:36 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16cw1d-0006yP-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> DMI 2.3 present.
> 44 structures occupying 1330 bytes.
> DMI table at 0x17FF0000.
> dmi: read: Illegal seek

Eep I don't deal with DMI tables that high in memory.
