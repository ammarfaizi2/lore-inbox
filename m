Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292141AbSBAX3x>; Fri, 1 Feb 2002 18:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292140AbSBAX3g>; Fri, 1 Feb 2002 18:29:36 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:9996 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292139AbSBAX3V>; Fri, 1 Feb 2002 18:29:21 -0500
Subject: Re: Machines misreporting Bogomips
To: gboyce@rakis.net (Greg Boyce)
Date: Fri, 1 Feb 2002 23:41:39 +0000 (GMT)
Cc: gmack@innerfire.net, brand@jupiter.cs.uni-dortmund.de (Horst von Brand),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.42.0202011549090.5498-100000@egg> from "Greg Boyce" at Feb 01, 2002 03:53:28 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16WnJL-0006Tg-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The machine is reporting that the cache is enabled.  Even if this was
> true, I have trouble believing that turning on the cache would result in a
> 50,000% increase in speed (4 bogomips compared to 500).

L1 and L2 cache both disabled comes up as about 2.5 bogomips typically on
a Pentium II/III.

