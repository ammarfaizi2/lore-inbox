Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293182AbSCWOUY>; Sat, 23 Mar 2002 09:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293187AbSCWOUE>; Sat, 23 Mar 2002 09:20:04 -0500
Received: from zeus.kernel.org ([204.152.189.113]:9201 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S293182AbSCWOTx>;
	Sat, 23 Mar 2002 09:19:53 -0500
Message-Id: <200203231419.g2NEJuV01771@gs176.sp.cs.cmu.edu>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Dave Zarzycki <dave@zarzycki.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org, ahaas@neosoft.com
Subject: Re: BUG: 2.4.18 & ALI15X3 DMA hang on boot 
In-Reply-To: Your message of "Sat, 23 Mar 2002 14:25:17 +0100."
             <3C9C823D.3080705@evision-ventures.com> 
Date: Sat, 23 Mar 2002 09:19:55 -0500
From: John Langford <jcl@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>But before could you just tell the m5229_revision value
>on your system?

I'm not sure what you mean.  Certainly, lspci says:

>00:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c3) (prog-if fa)
							       ^^^^^^^^

-John
