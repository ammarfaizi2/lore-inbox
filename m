Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311840AbSCNWlg>; Thu, 14 Mar 2002 17:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311841AbSCNWla>; Thu, 14 Mar 2002 17:41:30 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:63236 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311840AbSCNWlO>; Thu, 14 Mar 2002 17:41:14 -0500
Subject: Re: IO delay, port 0x80, and BIOS POST codes
To: root@chaos.analogic.com
Date: Thu, 14 Mar 2002 22:56:46 +0000 (GMT)
Cc: hpa@zytor.com (H. Peter Anvin), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1020314165931.715A-100000@chaos.analogic.com> from "Richard B. Johnson" at Mar 14, 2002 05:11:51 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16le9O-00028r-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yeh?  Then "how do it know?". It doesn't. I/O instructions are ordered,
> however, that's all. There is no bus-interface state machine that exists

How about because
	o	The intel docs say out is synchronizing
	o	HPA works for an x86 clone manufacturer

Alan
