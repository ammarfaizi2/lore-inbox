Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278424AbRJMVrE>; Sat, 13 Oct 2001 17:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278423AbRJMVqz>; Sat, 13 Oct 2001 17:46:55 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:32008 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S278425AbRJMVqq>; Sat, 13 Oct 2001 17:46:46 -0400
Subject: Re: Problem with store fence fixes
To: lgouv@planetinternet.be
Date: Sat, 13 Oct 2001 22:53:05 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <20011013222518.A1559@loclhost> from "Leopold Gouverneur" at Oct 13, 2001 10:25:18 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15sWiP-0003v9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	Unexpected IRQ trap at vector 75
> 	Calibrating delay loop ..
> Only the reset button helps. 2.4.10-ac8 works perfectly, ac9 also
> if I suppress the line "define_bool CONFIG_X86_PPRO_FENCE y".
> Since nobody is complaining, I suppose i am doing something wrong.
> My system: Abit BP6, 2 Celeron 433( not OC )

I would guess you are using gcc 3.0.*

Alan
