Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275816AbRJNRTl>; Sun, 14 Oct 2001 13:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275811AbRJNRTb>; Sun, 14 Oct 2001 13:19:31 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:38925 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S275790AbRJNRTS>; Sun, 14 Oct 2001 13:19:18 -0400
Subject: Re: Linux locks up (100+ node network; Have tried different kernels,
To: kernellist@source.intac.net
Date: Sun, 14 Oct 2001 18:25:13 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0110132154160.5530-100000@source.intac.net> from "kernellist@source.intac.net" at Oct 13, 2001 10:37:41 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15sp0k-0007vs-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> WARNING: MP table in the EBDA can be UNSAFE,
> contact linux-smp@vger.kernel.org if you experience SMP problems!

This is fine. The EBDA got stomped by older versions of LILO so the
warning was about that.

Alan
