Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbRAEPQd>; Fri, 5 Jan 2001 10:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129401AbRAEPQW>; Fri, 5 Jan 2001 10:16:22 -0500
Received: from hera.cwi.nl ([192.16.191.1]:27285 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S129383AbRAEPQK>;
	Fri, 5 Jan 2001 10:16:10 -0500
Date: Fri, 5 Jan 2001 16:16:04 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200101051516.QAA144658.aeb@texel.cwi.nl>
To: Andries.Brouwer@cwi.nl, maillist@chello.nl
Subject: Re: 2.2.18 and Maxtor 96147H6 (61 GB)
Cc: haegar@cut.de, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I need to look at fdisk, because it is doing things wrong.

I don't think so, unless you have a really old version.

> Linux sees the correct size, but fdisk still sees 32 GB.
> Probably a recompile / upgrade.

Yes, upgrade in case your version is older than 2.10i.

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
