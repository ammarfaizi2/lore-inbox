Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130198AbQLVTDH>; Fri, 22 Dec 2000 14:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130425AbQLVTC5>; Fri, 22 Dec 2000 14:02:57 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:20996 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130198AbQLVTCi>; Fri, 22 Dec 2000 14:02:38 -0500
Subject: Re: rtl8139 driver broken? (2.2.16)
To: Stefan.Hoffmeister@Econos.de (Stefan Hoffmeister)
Date: Fri, 22 Dec 2000 18:34:46 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <vb074t8d27bdedg6m7pv4c4qqu1f8324cq@4ax.com> from "Stefan Hoffmeister" at Dec 22, 2000 06:23:05 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E149X1l-00051k-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Questions: 
> * Is the rtl8139 driver broken?

Somewhat, especially in kernels that old

2.2.18 might help and also as an '8139too' driver rewrite which may work 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
