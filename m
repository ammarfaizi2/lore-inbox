Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287939AbSAMBa3>; Sat, 12 Jan 2002 20:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287436AbSAMBaT>; Sat, 12 Jan 2002 20:30:19 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:24836 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287289AbSAMBaK>; Sat, 12 Jan 2002 20:30:10 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
To: rml@tech9.net (Robert Love)
Date: Sun, 13 Jan 2002 01:41:41 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), landley@trommello.org (Rob Landley),
        yodaiken@fsmlabs.com, nigel@nrg.org, akpm@zip.com.au (Andrew Morton),
        linux-kernel@vger.kernel.org
In-Reply-To: <1010880963.3619.10.camel@phantasy> from "Robert Love" at Jan 12, 2002 07:16:03 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16PZeX-0003ii-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For a solution to latency concerns, I'd much prefer to lay a framework
> down that provides a proper solution and then work on fine tuning the
> kernel to get the desired latency out of it.

As the low latency patch proves, the framework has always been there, the
ll patches do the rest
