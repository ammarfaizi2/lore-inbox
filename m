Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131402AbRBJTa0>; Sat, 10 Feb 2001 14:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130529AbRBJTaQ>; Sat, 10 Feb 2001 14:30:16 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:48138 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131402AbRBJT37>; Sat, 10 Feb 2001 14:29:59 -0500
Subject: Re: Unresolved symbols for wavelan_cs in 2.4.1-ac9
To: dag@mind.be (Dag Wieers)
Date: Sat, 10 Feb 2001 19:29:40 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <Pine.LNX.4.32.0102101819490.11777-100000@pikachu.3ti.org> from "Dag Wieers" at Feb 10, 2001 06:34:29 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14RfiI-0002AB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I noticed a single unresolved symbol in wavelan_cs.o and I fixed it as
> described below.

Rejected. It is meant not to be there.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
