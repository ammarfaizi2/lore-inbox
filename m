Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281012AbRKLV3V>; Mon, 12 Nov 2001 16:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281016AbRKLV3B>; Mon, 12 Nov 2001 16:29:01 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:52497 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281012AbRKLV2v>; Mon, 12 Nov 2001 16:28:51 -0500
Subject: Re: ramfs leak
To: padraig@antefacto.com (Padraig Brady)
Date: Mon, 12 Nov 2001 21:35:08 +0000 (GMT)
Cc: tachino@open.nm.fujitsu.co.jp (Tachino Nobuhiro),
        wcm@catnap.com (W Christopher Martin), linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <3BF01660.3040509@antefacto.com> from "Padraig Brady" at Nov 12, 2001 06:35:12 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E163OjU-0007Bk-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> and I was just getting to the bottom of it myself :-)
> None of this accounting stuff is in 2.4.15-pre3, so Alan
> can you apply this?

RAMfs is 2.4.16 stuff I think
