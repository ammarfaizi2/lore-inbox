Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314465AbSEQL7J>; Fri, 17 May 2002 07:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314553AbSEQL7I>; Fri, 17 May 2002 07:59:08 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:26634 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314465AbSEQL7H>; Fri, 17 May 2002 07:59:07 -0400
Subject: Re: Still no ramfs usage limits in 2.5.9 or 2.4.19-pre8
To: padraig@antefacto.com (Padraig Brady)
Date: Fri, 17 May 2002 13:18:53 +0100 (BST)
Cc: dale@farnsworth.org (Dale Farnsworth), linux-kernel@vger.kernel.org
In-Reply-To: <3CE4E319.8070800@antefacto.com> from "Padraig Brady" at May 17, 2002 12:01:45 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E178ghB-0006JV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Linus said the code should be kept as simple
> as possible because it's only an example file system.
> However simple should also not mean practically useless.

Its useless as an example too - because it has no examples of error
handling
