Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129485AbRAAUEO>; Mon, 1 Jan 2001 15:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129697AbRAAUEE>; Mon, 1 Jan 2001 15:04:04 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:38415 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129485AbRAAUD4>; Mon, 1 Jan 2001 15:03:56 -0500
Subject: Re: [PATCH] cs46xx deadlocks in non-blocking read
To: dhd@eradicator.org (David Huggins-Daines)
Date: Mon, 1 Jan 2001 19:34:49 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <87y9wvhykx.fsf@monolith.cepstral.com> from "David Huggins-Daines" at Jan 01, 2001 02:17:02 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14DAjN-0001EH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've already sent this to Nils/Thomas but since it hasn't materialized
> in prerelease or ac1, and since it's quite small and needed for a
> number of things to function correctly, I'm sending it again in the
> hopes that it will get applied before 2.4 final.

Thanks

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
