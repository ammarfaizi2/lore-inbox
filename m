Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315358AbSEVOkJ>; Wed, 22 May 2002 10:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315441AbSEVOiu>; Wed, 22 May 2002 10:38:50 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:48913 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315358AbSEVOis>; Wed, 22 May 2002 10:38:48 -0400
Subject: Re: [PATCH] 2.5.17 /dev/ports
To: vojtech@suse.cz (Vojtech Pavlik)
Date: Wed, 22 May 2002 15:58:38 +0100 (BST)
Cc: dalecki@evision-ventures.com (Martin Dalecki),
        vojtech@suse.cz (Vojtech Pavlik), alan@lxorguk.ukuu.org.uk (Alan Cox),
        padraig@antefacto.com (Padraig Brady),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <20020522155603.B765@ucw.cz> from "Vojtech Pavlik" at May 22, 2002 03:56:03 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17AXZW-0001wM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > IOCTL is ineed the way to go to implement such functionality...
> 
> Yes, the EVIOCSREP ioctl will be the one soon (works for USB keyboards
> now).

The KBDRATE ioctl is already supported by all other keyboard drivers and
used by XFree86....
