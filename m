Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262035AbREQQsE>; Thu, 17 May 2001 12:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262037AbREQQry>; Thu, 17 May 2001 12:47:54 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:59921 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262035AbREQQrl>; Thu, 17 May 2001 12:47:41 -0400
Subject: Re: VIA/PDC/Athlon
To: jlaako@pp.htv.fi (Jussi Laako)
Date: Thu, 17 May 2001 17:44:37 +0100 (BST)
Cc: vojtech@suse.cz (Vojtech Pavlik), linux-kernel@vger.kernel.org
In-Reply-To: <3B03FFCC.B620AA68@pp.htv.fi> from "Jussi Laako" at May 17, 2001 07:43:56 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E150QtB-0005aC-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > There were no changes lately in the VIA driver. Can you spot where the
> > problems begun?
> 
> RH 2.4.2-2 works correctly, but 2.4.4-ac9 doesn't. I think 2.4.3 didn't
> work.

RH 2.4.2-2 and 2.4.4-ac9 are I believe the same driver exactly. 2.4.3 is an
ancient known not to work well driver
