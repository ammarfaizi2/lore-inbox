Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270797AbRHNUPY>; Tue, 14 Aug 2001 16:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270799AbRHNUPN>; Tue, 14 Aug 2001 16:15:13 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:54020 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270711AbRHNUPE>; Tue, 14 Aug 2001 16:15:04 -0400
Subject: Re: [PATCH] CDP handler for linux
To: chrisc@shad0w.org.uk (Chris Crowther)
Date: Tue, 14 Aug 2001 21:17:06 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0108141934130.3283-100000@monolith.shad0w.org.uk> from "Chris Crowther" at Aug 14, 2001 07:47:05 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Wkcc-0001r2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	I've been working on an addition to the kernel over the past
> couple of days that enables the kernel to interpret CDP (Cisco Discovery
> Protocol) packets which can be transmited by various pieces of Cisco kit.

It looks well written. I do have only one question, other than "because
I wanted to learn how to do it this way", is there a reason for putting
this into kernel space not a daemon ?

Alan
