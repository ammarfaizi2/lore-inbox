Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292592AbSBZSNB>; Tue, 26 Feb 2002 13:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292633AbSBZSMx>; Tue, 26 Feb 2002 13:12:53 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:31762 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292639AbSBZSMg>; Tue, 26 Feb 2002 13:12:36 -0500
Subject: Re: IDE error on 2.4.17
To: turveysp@ntlworld.com (Simon Turvey)
Date: Tue, 26 Feb 2002 18:27:21 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <000901c1beec$6ac68940$030ba8c0@mistral> from "Simon Turvey" at Feb 26, 2002 05:38:35 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16fmJt-0001Xi-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=250746,
> sector=250680
> end_request: I/O error, dev 03:01 (hda), sector 250680

Uncorrectable error is a message from your disk, along the lines of "Hey
pal I wonder if the warranty has expired yet"

