Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270448AbRHSN4i>; Sun, 19 Aug 2001 09:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270450AbRHSN42>; Sun, 19 Aug 2001 09:56:28 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:9486 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270448AbRHSN4T>; Sun, 19 Aug 2001 09:56:19 -0400
Subject: Re: System Freeze after booting the kernel
To: raphead@dimensions.de (RAPHEAD)
Date: Sun, 19 Aug 2001 14:59:21 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01081911514000.00854@raphead> from "RAPHEAD" at Aug 19, 2001 11:51:40 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15YT6n-0004B2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> P200, 128 Meg Ram, 128 KB Cache on a SuperMicro Board.
> Seagate IDE Drive with 13Gig
> 
>                                                   
> --->Detailed Report
> 
> [1.] Linux freezes after Uncompressing Linux... OK, booting the kernel (no 
> numlock posssible)

Firstly check you built a kernel for pentium or lower processors, secondly
check you included console support - otherwise it may well be running but
without any console for you to tell
