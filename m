Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316763AbSFUTeh>; Fri, 21 Jun 2002 15:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316764AbSFUTeg>; Fri, 21 Jun 2002 15:34:36 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:45575 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316763AbSFUTeg>; Fri, 21 Jun 2002 15:34:36 -0400
Subject: Re: [PATCH] SCHED_FIFO and SCHED_RR scheduler fix, kernel 2.2.21
To: bhavesh@avaya.com (Bhavesh P. Davda)
Date: Fri, 21 Jun 2002 20:56:57 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
In-Reply-To: <3D137A16.2080303@avaya.com> from "Bhavesh P. Davda" at Jun 21, 2002 01:10:14 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17LUWf-0001YA-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What's going on with the kernel community? I posted a similar fix for 
> the 2.4.18 kernel, and it hasn't been picked up there either.

I've not seen that one. However the -ac tree uses a different scheduler
anyway. You should check if 2.4.19pre has the same problem and if so mail
Marcelo directly a patch
