Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288058AbSAUUJ7>; Mon, 21 Jan 2002 15:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288121AbSAUUJu>; Mon, 21 Jan 2002 15:09:50 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:7954 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288058AbSAUUJi>; Mon, 21 Jan 2002 15:09:38 -0500
Subject: Re: Intel SRCU31 - i2o_core hangs
To: abdank@gmx.de (****)
Date: Mon, 21 Jan 2002 20:21:56 +0000 (GMT)
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <3C4ABE6B.2C04DA74@gmx.de> from "****" at Jan 20, 2002 12:56:11 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Skx2-0000fw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> hardware: intel sbt2, 2 x pIII xeon, intel srcu31 raid controller
> os: rh 6.2
> kernel: 2.4.17

It works with the RH shipped 2.4.9. It may work with
2.4.18pre3-ac2/2.4.18pre4 as I sent Marcelo a possibl fix
