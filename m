Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284180AbRLKXIV>; Tue, 11 Dec 2001 18:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284178AbRLKXIK>; Tue, 11 Dec 2001 18:08:10 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:36359 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284177AbRLKXIB>; Tue, 11 Dec 2001 18:08:01 -0500
Subject: Re: IO degradation in 2.4.17-pre2 vs. 2.4.16
To: marcelo@conectiva.com.br (Marcelo Tosatti)
Date: Tue, 11 Dec 2001 23:14:03 +0000 (GMT)
Cc: dmaas@dcine.com (Dan Maas), davidsen@tmr.com (Bill Davidsen),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0112111944330.26533-100000@freak.distro.conectiva> from "Marcelo Tosatti" at Dec 11, 2001 07:44:43 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Dw67-0007Hx-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Time for CONFIG_OPTIMIZE_THROUGHPUT / CONFIG_OPTIMIZE_LATENCY ?
> That would be the best thing to do, yes.

/proc/sys not CONFIG_..
