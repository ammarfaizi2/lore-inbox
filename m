Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130286AbRBPKKS>; Fri, 16 Feb 2001 05:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130287AbRBPKKI>; Fri, 16 Feb 2001 05:10:08 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:4879 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130286AbRBPKJv>; Fri, 16 Feb 2001 05:09:51 -0500
Subject: Re: 8139 full duplex?
To: R.E.Wolff@BitWizard.nl (Rogier Wolff)
Date: Fri, 16 Feb 2001 10:09:55 +0000 (GMT)
Cc: jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org
In-Reply-To: <200102160858.JAA02472@cave.bitwizard.nl> from "Rogier Wolff" at Feb 16, 2001 09:58:53 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Thpt-0002jE-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Would this mean that the driver/card already were in full-duplex? That
> would explain me seeing way too many collisions on that old hub (which
> obviously doesn't support full-duplex).

Most likely it means they were set to autonegotiate
