Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbRAYBdc>; Wed, 24 Jan 2001 20:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135354AbRAYBdW>; Wed, 24 Jan 2001 20:33:22 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:54290 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129383AbRAYBdG>; Wed, 24 Jan 2001 20:33:06 -0500
Subject: Re: CPU error codes
To: jsimmons@suse.com (James Simmons)
Date: Thu, 25 Jan 2001 01:34:29 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <Pine.LNX.4.21.0101241130280.10902-100000@euclid.oak.suse.com> from "James Simmons" at Jan 24, 2001 11:30:48 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14LbJ2-0008Be-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I was wondering if someone could tell me where I can find
> Xeon Pentium III cpu error messages/codes

In the intel databook. Generally an MCE indicates hardware/power/cooling
issues
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
