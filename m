Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271978AbRH2Oar>; Wed, 29 Aug 2001 10:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271982AbRH2Oah>; Wed, 29 Aug 2001 10:30:37 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:52486 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271978AbRH2OaY>; Wed, 29 Aug 2001 10:30:24 -0400
Subject: Re: Keeping the 'cached' memory under control
To: monkeyiq@users.sourceforge.net (monkeyiq)
Date: Wed, 29 Aug 2001 15:33:52 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, monkeyiq@users.sourceforge.net
In-Reply-To: <200108291300.f7TD05T01627@monkeyiq.dnsalias.org> from "monkeyiq" at Aug 29, 2001 11:00:05 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15c6Pg-0007gR-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   Also my special internet keys didn't work on the ac tree from my
> USB keyboard but using the same .config work fine in 2.4.9 anyone
> experienced a similar thing? This is with vmlinuz-2.4.7-ac9 and some
> 2.4.8-ac kernels that I've tried.

The -ac tree has a newer input device layer so check you have the hid not
hidbp based modules loaded  and report it to the input device maintainer
