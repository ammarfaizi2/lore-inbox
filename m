Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265152AbRFUTZU>; Thu, 21 Jun 2001 15:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265149AbRFUTZA>; Thu, 21 Jun 2001 15:25:00 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:32260 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265148AbRFUTYt>; Thu, 21 Jun 2001 15:24:49 -0400
Subject: Re: Controversy over dynamic linking -- how to end the panic
To: lkml@sigkill.net (Disconnect)
Date: Thu, 21 Jun 2001 20:24:15 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20010621152226.E13649@sigkill.net> from "Disconnect" at Jun 21, 2001 03:22:28 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15DA3r-0001zV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> IANAL, and this may be a dumb question, but what about LGPLing the driver
> abstraction layer and/or headers? (Presuming of course there -is- a driver

GPL + LGPL gives you GPL so it doesnt help. You can combine it with the driver
or with the kernel but not with both together.



