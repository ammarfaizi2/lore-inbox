Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129400AbRBLXYW>; Mon, 12 Feb 2001 18:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129452AbRBLXYM>; Mon, 12 Feb 2001 18:24:12 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:6150 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129400AbRBLXYA>; Mon, 12 Feb 2001 18:24:00 -0500
Subject: Re: LILO and serial speeds over 9600
To: hpa@transmeta.com (H. Peter Anvin)
Date: Mon, 12 Feb 2001 23:23:22 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), jas88@cam.ac.uk (James Sutherland),
        hpa@zytor.com (H. Peter Anvin), linux-kernel@vger.kernel.org
In-Reply-To: <3A886F73.759DB067@transmeta.com> from "H. Peter Anvin" at Feb 12, 2001 03:19:15 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14SSJZ-0008T5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I *REALLY* don't know if that is reasonable; it may have to fall into the
> category of "supported but not required".  Requiring an SHA hash in a
> small bootstrap loader may not exactly be a reasonable expectation! 

tea is very very small so may be appropriate instead.

> However, I think the protocol is inherently going to be asymmetric, with
> as much as possible unloaded.

Nod.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
