Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315520AbSECBMn>; Thu, 2 May 2002 21:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315521AbSECBMn>; Thu, 2 May 2002 21:12:43 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:22532 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315520AbSECBMl>; Thu, 2 May 2002 21:12:41 -0400
Subject: Re: Re[6]: Support of AMD 762?
To: ekuznetsov@divxnetworks.com
Date: Fri, 3 May 2002 02:31:47 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <197354375.20020502180902@divxnetworks.com> from "Eugene Kuznetsov" at May 02, 2002 06:09:02 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E173RvH-0005Nb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Without noapic, the output from previous email was with MP 1.1. With
> MP 1.4 kernel hangs somewhere near "calibrating APIC timer". With
> noapic it seems to work with both 1.1 and 1.4.

Would this be an ASUS A7M-266D ? If so it seems to randomly depend on which
BIOS you have what actually works. Find a BIOS that works and dont touch
it 8)
