Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129348AbRACOpA>; Wed, 3 Jan 2001 09:45:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130139AbRACOou>; Wed, 3 Jan 2001 09:44:50 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:18440 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129348AbRACOoj>; Wed, 3 Jan 2001 09:44:39 -0500
Subject: Re: [PATCH] 2.4.0-prerelease-ac4: i810_audio.c: Alternate VRA fix
To: anwar@austin.rr.com (Anwar Payyoorayil)
Date: Wed, 3 Jan 2001 14:16:21 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <3A7BB6B1.ABF71834@austin.rr.com> from "Anwar Payyoorayil" at Feb 03, 2001 01:43:45 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14DoiG-00041w-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If we find that somebody needs this reset, we can move the VRA enabling code
> after the codec reset code.

Thanks. That now all makes sense
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
