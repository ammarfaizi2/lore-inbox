Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130295AbRBLRKI>; Mon, 12 Feb 2001 12:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130385AbRBLRJ6>; Mon, 12 Feb 2001 12:09:58 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:10771 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130295AbRBLRJj>; Mon, 12 Feb 2001 12:09:39 -0500
Subject: Re: 2.2.16-22 -> 2.4.0 breaks cpuid on Cyrix/IBM 6x86L-PR200+
To: fpn@pobox.com
Date: Mon, 12 Feb 2001 17:10:23 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010212090434.A8834@fpn.dyndns.org> from "fpn@pobox.com" at Feb 12, 2001 09:04:34 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14SMUc-0007Wx-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I run RedHat 7 with 2.2.16-22 and 2.4.0
> Under 2.2.16-22 that is not the case (it just works). I think (but can't
> easily verify) that I never saw that problem under 2.2.x.
> The Processor in question is a 6x86-L-PR200 from Cyrix/IBM.

Can you tell me if it works ok in 2.4.1ac9. I think its fixed indirectly from
a couple of other things. If not I know whats up I think

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
