Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129130AbQKEMTM>; Sun, 5 Nov 2000 07:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129246AbQKEMTD>; Sun, 5 Nov 2000 07:19:03 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:16691 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129130AbQKEMS6>; Sun, 5 Nov 2000 07:18:58 -0500
Subject: Re: Select
To: David_Feuer@brown.edu (David Feuer)
Date: Sun, 5 Nov 2000 12:19:56 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4.3.2.7.2.20001105014402.00adee30@postoffice.brown.edu> from "David Feuer" at Nov 05, 2000 01:46:19 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13sOmE-0005KG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> wake up a process until the buffer is half full (or all full, or 
> whatever).  Does this mean that if a small amount is written to the 

Writer not reader
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
