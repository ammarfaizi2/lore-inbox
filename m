Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266820AbRGFToB>; Fri, 6 Jul 2001 15:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266821AbRGFTnw>; Fri, 6 Jul 2001 15:43:52 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:41989 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S266820AbRGFTnl>; Fri, 6 Jul 2001 15:43:41 -0400
Subject: Re: funky tyan s2510
To: skulcap@mammoth.org (josh)
Date: Fri, 6 Jul 2001 20:43:54 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0107061109400.20154-100000@hannibal.mammoth.org> from "josh" at Jul 06, 2001 02:39:24 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15IbW6-0004pr-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> gcc never gets all the way through a make... it will die with a
> sig11, misc asm errors, or random crap.

If its doing that at random then suspect hardaware

> This is a serverworks chipset... i have always thought that they were
> a bit, you know, funny.  :)   

Serverworks have an obscure MTRR bug in a few chips (which we handle) but
quite honestly they don't show up a lot in kernel bug reports.



Alan

