Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264769AbRFXVhU>; Sun, 24 Jun 2001 17:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264771AbRFXVhA>; Sun, 24 Jun 2001 17:37:00 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:58888 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264769AbRFXVgs>; Sun, 24 Jun 2001 17:36:48 -0400
Subject: Re: Thrashing WITHOUT swap.
To: maze@druid.if.uj.edu.pl (Maciej Zenczykowski)
Date: Sun, 24 Jun 2001 22:36:25 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0106242133550.19801-100000@druid.if.uj.edu.pl> from "Maciej Zenczykowski" at Jun 24, 2001 09:47:30 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15EHYP-0000VC-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> recompiled it yet).  I have a 140 mb swap partition set up but at the time
> this happened it was OFF.  I was (still am) running X + twm + two xterms
> 
> top gives me:
> mem: 62144k av, 61180k used, 956k free, 0k shrd, 76 buff, 2636 cached
> swap: 0k av, 0k used, 0k free [as expected]

Not as expected - 0k used 0k free - you have no swap

Alan

