Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272089AbRHVTDS>; Wed, 22 Aug 2001 15:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272086AbRHVTDI>; Wed, 22 Aug 2001 15:03:08 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:8208 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272089AbRHVTCy>; Wed, 22 Aug 2001 15:02:54 -0400
Subject: Re: Qlogic/FC firmware
To: jfbeam@bluetopia.net (Ricky Beam)
Date: Wed, 22 Aug 2001 20:05:56 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), davem@redhat.com (David S. Miller),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.33.0108221431060.6389-100000@sweetums.bluetronic.net> from "Ricky Beam" at Aug 22, 2001 02:46:27 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ZdK8-00025A-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -#include "qlogicfc_asm.c"
> +//#include "qlogicfc_asm.c"
> 
> (I will note, that's not even a valid C construct. '//' is a C++ism.)

Your C standard is as out of date as your architecture ;)

