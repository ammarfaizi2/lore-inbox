Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131416AbRBLW06>; Mon, 12 Feb 2001 17:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131519AbRBLW0s>; Mon, 12 Feb 2001 17:26:48 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:46597 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131416AbRBLW0a>; Mon, 12 Feb 2001 17:26:30 -0500
Subject: Re: LILO and serial speeds over 9600
To: hpa@transmeta.com (H. Peter Anvin)
Date: Mon, 12 Feb 2001 22:25:47 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), jas88@cam.ac.uk (James Sutherland),
        hpa@zytor.com (H. Peter Anvin), linux-kernel@vger.kernel.org
In-Reply-To: <3A885F72.ED9ADAE8@transmeta.com> from "H. Peter Anvin" at Feb 12, 2001 02:10:58 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14SRPp-0008J1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is true, but one thing I'd really like to have is controlled buffer
> overrun, which TCP *doesn't* have.  I really think an ad hoc UDP protocol
> (I've already begun sketching on the details) is more appropriate in this
> particular case.

Explain 'controlled buffer overrun'. BTW if you make it UDP please include
something like SHA hash or tea hash and shared secret
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
