Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289351AbSA1UMz>; Mon, 28 Jan 2002 15:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289368AbSA1UMj>; Mon, 28 Jan 2002 15:12:39 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:57097 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289364AbSA1ULz>; Mon, 28 Jan 2002 15:11:55 -0500
Subject: Re: Athlon Optimization Problem
To: calin@ajvar.org (Calin A. Culianu)
Date: Mon, 28 Jan 2002 20:24:38 +0000 (GMT)
Cc: hassani@its.caltech.edu (Steven Hassani), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0201281452480.9637-200000@rtlab.med.cornell.edu> from "Calin A. Culianu" at Jan 28, 2002 02:56:04 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16VIKU-0001f7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Im still not convinced touching the register on the 266 chipset at 0x95 is
correct. I now have several reports of boxes that only work if you leave it
alone

Alan
