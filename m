Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285498AbSBCAu1>; Sat, 2 Feb 2002 19:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285023AbSBCAuQ>; Sat, 2 Feb 2002 19:50:16 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:45317 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285093AbSBCAt7>; Sat, 2 Feb 2002 19:49:59 -0500
Subject: Re: Does Linux (x86) support ECC memory?
To: reg@dwf.com
Date: Sun, 3 Feb 2002 01:03:03 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200202030018.g130IcB7001665@orion.dwf.com> from "reg@dwf.com" at Feb 02, 2002 05:18:38 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16XB3g-000128-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The subject says it all.
> I seem to see code for other platforms, but not the x86.

ECC memory is supported by some chipsets. For actual ECC error logging you
should see

	http://www.anime.net/~goemon/linux-ecc/

You do need to pick your chipset appripriately if you want support. In 
paticular serverworks won't provide docs.

Alan
