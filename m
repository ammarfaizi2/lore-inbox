Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314529AbSEXQYF>; Fri, 24 May 2002 12:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317195AbSEXQYE>; Fri, 24 May 2002 12:24:04 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28941 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314529AbSEXQYD>; Fri, 24 May 2002 12:24:03 -0400
Subject: Re: It hurts when I shoot myself in the foot
To: kasperd@daimi.au.dk (Kasper Dupont)
Date: Fri, 24 May 2002 16:50:17 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux-Kernel)
In-Reply-To: <3CEE5A2D.77EA2E66@daimi.au.dk> from "Kasper Dupont" at May 24, 2002 05:20:13 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17BHKb-0006hz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If the kernel knew multipliers couldn't it actually use the TSCs
> anyway? Of course it would take some work, but is there any
> reason why it would not be posible?

In 2.4 yes. In 2.5 it would be close to impossible due to the pre-empt code
