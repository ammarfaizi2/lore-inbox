Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292145AbSBAXro>; Fri, 1 Feb 2002 18:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292147AbSBAXre>; Fri, 1 Feb 2002 18:47:34 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:34316 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292145AbSBAXr1>; Fri, 1 Feb 2002 18:47:27 -0500
Subject: Re: Machines misreporting Bogomips
To: gboyce@rakis.net (Greg Boyce)
Date: Fri, 1 Feb 2002 23:59:56 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), gmack@innerfire.net,
        brand@jupiter.cs.uni-dortmund.de (Horst von Brand),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.42.0202011831170.6556-100000@egg> from "Greg Boyce" at Feb 01, 2002 06:34:47 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Wnb2-0006Z2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > L1 and L2 cache both disabled comes up as about 2.5 bogomips typically on
> > a Pentium II/III.
> 
> The machine I'm reporting shows 512K of cache though.  I included a second
> machine as a comparison, and apparently choose poorly.  That was the
> machine reporting no cache.

It isnt the amount of cache, it is whether the cache is enabled. You can
have 512K of cache showing that is disabled in software
