Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291151AbSBSKzE>; Tue, 19 Feb 2002 05:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291144AbSBSKy4>; Tue, 19 Feb 2002 05:54:56 -0500
Received: from E0-IBE.r.miee.ru ([194.226.0.89]:64272 "EHLO ibe.miee.ru")
	by vger.kernel.org with ESMTP id <S291126AbSBSKyo>;
	Tue, 19 Feb 2002 05:54:44 -0500
From: Samium Gromoff <root@ibe.miee.ru>
Message-Id: <200202191344.g1JDiUP12170@ibe.miee.ru>
Subject: Re: Ess Solo-1 interrupt behaviour
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Tue, 19 Feb 2002 16:44:28 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16d81Q-00008y-00@the-village.bc.nu> from "Alan Cox" at Feb 19, 2002 11:01:20 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"  Alan Cox wrote:"
> 
> >         I`ve recently spotted that a solo1 pci soundcard generates
> > 16000+ interrupts/second with esd started idling.
> 
> Thats an esd bug. ESD tries to use ridiculously small fragment sizes
> 
  Wait, wait, but my ISA Vibra 16 generates 20+ times less interrupts, with the
  _same_ esd! 
