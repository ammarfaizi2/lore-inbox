Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129733AbRBUOZn>; Wed, 21 Feb 2001 09:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130081AbRBUOZd>; Wed, 21 Feb 2001 09:25:33 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:54026 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129733AbRBUOZY>; Wed, 21 Feb 2001 09:25:24 -0500
Subject: Re: [lkml]2.2.19pre13: Are there network problem with a low-bandwidth
To: tenthumbs@cybernex.net
Date: Wed, 21 Feb 2001 14:27:40 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), thunder7@xs4all.nl,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0102210904390.151-100000@perfect.master> from "TenThumbs" at Feb 21, 2001 09:06:44 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14VaF5-0002AH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does this explain why the kernel sees bad segments? Do you know what
> changed between pre8 and pre10 so that I can undo it? Exactly which
> windows should be smaller?

It doesnt explain bad segments. 

TCP windows

