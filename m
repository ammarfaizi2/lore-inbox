Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130021AbQLPXBl>; Sat, 16 Dec 2000 18:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130117AbQLPXBb>; Sat, 16 Dec 2000 18:01:31 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:45325 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130021AbQLPXBR>; Sat, 16 Dec 2000 18:01:17 -0500
Subject: Re: Dropping chars on 16550
To: thomassr@erols.com (Tom Vier)
Date: Sat, 16 Dec 2000 22:32:29 +0000 (GMT)
Cc: cwslist@main.cornernet.com (Chad Schwartz), linux-kernel@vger.kernel.org
In-Reply-To: <20001216152833.A7536@zero> from "Tom Vier" at Dec 16, 2000 03:28:33 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E147PsV-0003HP-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> macs and sun machines use z85c30 chips, so there are some non-16550 boxes
> out there.

SGI kit also tends to use Z85Cx30 based devices. Its unfortunate the 16xx0
series serial controllers won as the Z85Cx30 is much more flexible ;)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
