Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262564AbREZXiF>; Sat, 26 May 2001 19:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262663AbREZXhz>; Sat, 26 May 2001 19:37:55 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:3338 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262564AbREZXhq>; Sat, 26 May 2001 19:37:46 -0400
Subject: Re: 2.4.4-ac[356]: network (8139too) related crashes
To: pavenis@latnet.lv (Andris Pavenis)
Date: Sun, 27 May 2001 00:34:27 +0100 (BST)
Cc: dth@trinity.hoho.nl (Danny ter Haar), linux-kernel@vger.kernel.org
In-Reply-To: <200105261349.f4QDnVx00377@hal.astr.lu.lv> from "Andris Pavenis" at May 26, 2001 04:49:31 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E153nZj-0008La-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Tried 2.4.5 and got the same problem again. Parhaps I'll sty with 2.4.3-ac3 
> for now. At least it doesn't freeze ...

Can you try 2.4.5 with the 8139too.c file from the 2.4.3-ac3 that works for
you and report on that
