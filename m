Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130100AbQKAPCD>; Wed, 1 Nov 2000 10:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131000AbQKAPBx>; Wed, 1 Nov 2000 10:01:53 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:30226 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130100AbQKAPBT>; Wed, 1 Nov 2000 10:01:19 -0500
Subject: Re: Linux-2.4.0-test10
To: tigran@veritas.com (Tigran Aivazian)
Date: Wed, 1 Nov 2000 15:01:23 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (Kernel Mailing List),
        dr@bofh.de (Daniel Roesen), richard.schaal@intel.com (Richard Schaal)
In-Reply-To: <Pine.LNX.4.21.0011011012510.1722-100000@saturn.homenet> from "Tigran Aivazian" at Nov 01, 2000 10:19:18 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13qzOG-0000TG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> for microcode update as family=6? The manuals suggest that test for ">" is
> correct, i.e. that Intel will maintain compatibility with P6 wrt microcode
> update.
> 
> Perhaps Richard can clarify this?

Until we know what the preventium IV does on microcode behaviour it seems
wisest to test for == not >.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
