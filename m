Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135906AbREIIn6>; Wed, 9 May 2001 04:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135912AbREIInt>; Wed, 9 May 2001 04:43:49 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:37384 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135906AbREIIno>; Wed, 9 May 2001 04:43:44 -0400
Subject: Re: 2.4.4 Kernel - ASUS CUV4X-DLS Question
To: ankh@canuck.gen.nz (J. S. Connell)
Date: Wed, 9 May 2001 09:47:30 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0105081841530.12740-100000@canuck.gen.nz> from "J. S. Connell" at May 08, 2001 06:57:50 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14xPd8-0001pf-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When it gets to the point of activating the second processor, kernel
> 2.4.3-ac13 starts spewing:
> 
> probable hardware bug: clock timer configuration lost - probably a VIA686a motherboard.
> probable hardware bug: restoring chip configuration.

That is useful informtion. The kernel is seeing the interval timer overrun
which implies things are very very stuck
