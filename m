Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131684AbRAaQNl>; Wed, 31 Jan 2001 11:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129805AbRAaQNM>; Wed, 31 Jan 2001 11:13:12 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:29192 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131395AbRAaQMx>; Wed, 31 Jan 2001 11:12:53 -0500
Subject: Re: hotmail can't deal with ECN
To: cat@zip.com.au (CaT)
Date: Wed, 31 Jan 2001 16:13:18 +0000 (GMT)
Cc: jan@gondor.com (Jan Niehusmann), linux-kernel@vger.kernel.org
In-Reply-To: <20010126120312.C366@zip.com.au> from "CaT" at Jan 26, 2001 12:03:12 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Nzso-0002bs-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > mean that hotmail doesn't get ECN packets and the connection gets established
> > just as if you were talking to a plain non-ECN server without a firewall.
> 
> gozer IS my firewall. :) beyond it is a modem and a dailup point, my ISPs
> LAN and then the innanet. and I tried from it and from a box behind it.
> I connected to hotmail just fine.

Most likely you are behind a transparent proxy
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
