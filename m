Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271693AbRHUOPQ>; Tue, 21 Aug 2001 10:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271692AbRHUOPG>; Tue, 21 Aug 2001 10:15:06 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:55313 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271691AbRHUOOv>; Tue, 21 Aug 2001 10:14:51 -0400
Subject: Re: Qlogic/FC firmware
To: davem@redhat.com (David S. Miller)
Date: Tue, 21 Aug 2001 15:17:25 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, jes@sunsite.dk, linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "David S. Miller" at Aug 21, 2001 06:45:34 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ZCLO-0007wK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In many cases the driver worked before, and fails to work afterwards.
> I still contend that the whole driver should have been lifted
> instead of leaving a crippled version there.

Well now you know how everyone feels about the min() and max() changes.

However I _did_ test this, you can update the firmware in your BIOS flash
if you want a specific version and you have out of date firmwre currently
loaded.

Alan
