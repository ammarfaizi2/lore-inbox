Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286411AbSA2XZq>; Tue, 29 Jan 2002 18:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286895AbSA2XYg>; Tue, 29 Jan 2002 18:24:36 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:10762 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287106AbSA2XXp>; Tue, 29 Jan 2002 18:23:45 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
To: davidsen@tmr.com (Bill Davidsen)
Date: Tue, 29 Jan 2002 23:33:24 +0000 (GMT)
Cc: jussi.laako@kolumbus.fi (Jussi Laako),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <Pine.LNX.3.96.1020129180237.31511G-100000@gatekeeper.tmr.com> from "Bill Davidsen" at Jan 29, 2002 06:05:28 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Vhki-0005W0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It was 15 by the time I tried it, but I'm still running it. What sched is
> in pre7ac1? I looked at the post Alan put up and didn't see it on the
> first pass. The Jn scheduler and and low latency seem to play well with

I've not touched the scheduler at all. Its in somewhat of a bit of flux
and I'm trying to accumulate stuff to go to Marcelo sooner not later
