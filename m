Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291214AbSBSLLF>; Tue, 19 Feb 2002 06:11:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291243AbSBSLKv>; Tue, 19 Feb 2002 06:10:51 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:13325 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291214AbSBSLI3>; Tue, 19 Feb 2002 06:08:29 -0500
Subject: Re: Ess Solo-1 interrupt behaviour
To: root@ibe.miee.ru (Samium Gromoff)
Date: Tue, 19 Feb 2002 11:16:42 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <200202191344.g1JDiUP12170@ibe.miee.ru> from "Samium Gromoff" at Feb 19, 2002 04:44:28 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16d8GI-0000CS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Thats an esd bug. ESD tries to use ridiculously small fragment sizes
> > 
>   Wait, wait, but my ISA Vibra 16 generates 20+ times less interrupts, with the
>   _same_ esd! 

Yes. It has diff fragment limits
