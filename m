Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292362AbSBBTZn>; Sat, 2 Feb 2002 14:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292363AbSBBTZe>; Sat, 2 Feb 2002 14:25:34 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28434 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292362AbSBBTZP>; Sat, 2 Feb 2002 14:25:15 -0500
Subject: Re: 2.5.2 cmpci.c Compilation error
To: panxer@hol.gr (Panagiotis Moustafellos)
Date: Sat, 2 Feb 2002 19:38:22 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <02020220012604.00250@gryppas> from "Panagiotis Moustafellos" at Feb 02, 2002 08:01:26 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16X5zS-0000J5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> and goes on for some more lines..
> Is this a known bug? could it be that some options are conflicting?
> Thanks in advance,

Most 2.5 sound driver code is currently broken. It's waiting the ALSA
merge
