Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317195AbSEXQYg>; Fri, 24 May 2002 12:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317196AbSEXQYf>; Fri, 24 May 2002 12:24:35 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:29709 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S317195AbSEXQYd>; Fri, 24 May 2002 12:24:33 -0400
Subject: Re: Compiling 2.2.19 with -O3 flag
To: rml@tech9.net (Robert Love)
Date: Fri, 24 May 2002 16:44:51 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        intellectcrew@yahoo.com (samson swanson), linux-kernel@vger.kernel.org
In-Reply-To: <1022253543.962.236.camel@sinai> from "Robert Love" at May 24, 2002 08:19:03 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17BHFL-0006fF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Or maybe not - not too long ago I did some tests of the various
> optimization options in gcc 2.96 or so and found that -O2 generates
> smaller code in most cases than -Os.  -Os also did not perform as good,
> but I was just testing a few bits of code - nothing as versatile as the
> kernel.

I've done that test with 2.95 and egcs-1.1.2 (its a while back). I've not
check with 2.96, 3.0.4 or 3.1
