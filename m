Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271716AbRHUPYb>; Tue, 21 Aug 2001 11:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271718AbRHUPYU>; Tue, 21 Aug 2001 11:24:20 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:57106 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271716AbRHUPYS>; Tue, 21 Aug 2001 11:24:18 -0400
Subject: Re: Qlogic/FC firmware
To: davem@redhat.com (David S. Miller)
Date: Tue, 21 Aug 2001 16:26:55 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, jes@sunsite.dk, linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "David S. Miller" at Aug 21, 2001 07:46:28 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ZDQd-00085r-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We saved nothing, __init_data the firmware, problem solved.

Except when its modular, as in 99% of distro kernels

> If the firmware was out of date, update it to a known "Qlogic stamp of
> approval" version.

That requires sorting licensing out with Qlogic. I've talked to them
usefully about other stuff so I'll pursue it for a seperate firmware
loader module.

Alan
