Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131382AbRDBW1a>; Mon, 2 Apr 2001 18:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131424AbRDBW1K>; Mon, 2 Apr 2001 18:27:10 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:32529 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131382AbRDBW1F>; Mon, 2 Apr 2001 18:27:05 -0400
Subject: Re: Asus CUV4X-D, 2.4.3 crashes at boot
To: lkml@campbell.cwx.net (Allen Campbell)
Date: Mon, 2 Apr 2001 23:27:27 +0100 (BST)
Cc: sgarner@expio.co.nz (Simon Garner), linux-kernel@vger.kernel.org
In-Reply-To: <20010331221319.A95411@const.> from "Allen Campbell" at Mar 31, 2001 10:13:19 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14kCnK-0006pa-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've seen the exact same behavior with my CUV4X-D (2x1GHz) under
> 2.4.2 (debian woody).  In addition, the kernel would sometimes hang
> around NMI watchdog enable.  At least, I think it's trying to

Known problem. Thats one reason why -ac trees had nmi watchdog turned off.
