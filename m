Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292858AbSCAWCA>; Fri, 1 Mar 2002 17:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292859AbSCAWBu>; Fri, 1 Mar 2002 17:01:50 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:46859 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292858AbSCAWBj>; Fri, 1 Mar 2002 17:01:39 -0500
Subject: Re: PROBLEM: IDS2000 crashed during kernel oops.
To: FredoDavid@gmx.net (Fredo David)
Date: Fri, 1 Mar 2002 22:16:36 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C7FF7E8.9020200@gmx.net> from "Fredo David" at Mar 01, 2002 10:51:36 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16gvKO-0005D2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> During a Kernel- Update from 2.2.16 to 2.2.19 with SuSE Linux 7.0 we ran
> into the following problem. We use an Informix DB with raw devices.

> Mar  1 11:40:43 srvixdb1 kernel: EIP: 0010:[kiobuf_copy_bounce+155/204]
> Mar  1 11:40:43 srvixdb1 kernel: EFLAGS: 00010206

You need to report this to SuSE - standard Linux 2.2 doesn't have kiobuf's
unless my memory is failing.
