Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269728AbRHIIIh>; Thu, 9 Aug 2001 04:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269731AbRHIII1>; Thu, 9 Aug 2001 04:08:27 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:44305 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269728AbRHIIIN>; Thu, 9 Aug 2001 04:08:13 -0400
Subject: Re: APM poweroff under Linux 2.4.7 / 2.4.2 RH 7.1
To: rhw@MemAlpha.CX (Riley Williams)
Date: Thu, 9 Aug 2001 09:09:36 +0100 (BST)
Cc: sfr@canb.auug.org.au (Stephen Rothwell),
        monniaux@di.ens.fr (David Monniaux),
        linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <Pine.LNX.4.33.0108090822460.10432-300000@infradead.org> from "Riley Williams" at Aug 09, 2001 08:34:51 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Uksr-0006um-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I put the 7.1 source CD in my drive and installed the relevant source
> RPM therefrom. There are 227 patches listed therein, which is way too
> many IMHO, and some of them clearly need to be considered for the
> generic kernel.

Most of them have been in -ac since the early days (the RH 2.4.2 is closer
to 2.4.3-ac than 2.4.2 in truth) and pushed on to Linus long ago
