Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311907AbSCOB4M>; Thu, 14 Mar 2002 20:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311904AbSCOBzz>; Thu, 14 Mar 2002 20:55:55 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:17159 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311903AbSCOBzn>; Thu, 14 Mar 2002 20:55:43 -0500
Subject: Re: 2.4.18 Preempt Freezeups
To: ian@ianduggan.net (Ian Duggan)
Date: Fri, 15 Mar 2002 02:11:20 +0000 (GMT)
Cc: rml@tech9.net (Robert Love), linux-kernel@vger.kernel.org (linux kernel)
In-Reply-To: <3C9153A7.292C320@ianduggan.net> from "Ian Duggan" at Mar 14, 2002 05:51:35 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16lhBg-0002Yc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Stock 2.4.18+preempt+mki-adapter+win4lin
> 	- Very frequent, and also repeatable every time I
> 		try to start win4lin.

pre-empt is almost certainly going to break things like win4lin
