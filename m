Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130331AbRAGVqG>; Sun, 7 Jan 2001 16:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131208AbRAGVp4>; Sun, 7 Jan 2001 16:45:56 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:60176 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130331AbRAGVpj>; Sun, 7 Jan 2001 16:45:39 -0500
Subject: Re: [PATCH] Cyrix III boot fix and bug report
To: hpa@zytor.com (H. Peter Anvin)
Date: Sun, 7 Jan 2001 21:47:12 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <93ans3$bd4$1@cesium.transmeta.com> from "H. Peter Anvin" at Jan 07, 2001 01:42:27 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14FNek-0003Nt-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> (Could this code have been written by someone who was confused between
> MSR 0x80000001 and CPUID 0x80000001?)

It looks like thats what happened. The docs say it has 3dnow and mmx but
I think your diagnosis is correct

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
