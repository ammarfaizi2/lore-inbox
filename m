Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132379AbRBEMqu>; Mon, 5 Feb 2001 07:46:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132435AbRBEMqa>; Mon, 5 Feb 2001 07:46:30 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:62226 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132379AbRBEMqZ>; Mon, 5 Feb 2001 07:46:25 -0500
Subject: Re: Problems with a Magik1 chipset board
To: loftwyr@sympatico.ca (David Pyke)
Date: Mon, 5 Feb 2001 12:47:26 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A8141FA.8040202@sympatico.ca> from "David Pyke" at Feb 07, 2001 07:39:22 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Pl3I-0003Ge-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Second, for agpgart I have to use try_agp_unsupported=1 which gets me
> agpgart: Trying generic Ali routines for device id: 1647

Use the 2.4.1-ac patches, those should give you AGP


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
