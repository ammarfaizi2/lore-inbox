Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129661AbRBXWQt>; Sat, 24 Feb 2001 17:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129662AbRBXWQj>; Sat, 24 Feb 2001 17:16:39 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:57348 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129661AbRBXWQY>; Sat, 24 Feb 2001 17:16:24 -0500
Subject: Re: mtrr message
To: thockin@isunix.it.ilstu.edu (Tim Hockin)
Date: Sat, 24 Feb 2001 22:19:06 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200102242145.PAA26761@isunix.it.ilstu.edu> from "Tim Hockin" at Feb 24, 2001 03:45:37 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Wn1w-0000bE-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm noticing these messages:
> 
> 	mtrr: base(0xd4000000) is not aligned on a size(0x1800000) boundary
> :many times in dmesg.  System is a dual P3-933 on a MSI 694D board (Apollo
> Pro 133).
> 
> Is it worrisome?

Possibly a slight performance loss

