Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311839AbSCNWkq>; Thu, 14 Mar 2002 17:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311840AbSCNWkg>; Thu, 14 Mar 2002 17:40:36 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:60420 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311839AbSCNWkR>; Thu, 14 Mar 2002 17:40:17 -0500
Subject: Re: IO delay, port 0x80, and BIOS POST codes
To: kerndev@sc-software.com (John Heil)
Date: Thu, 14 Mar 2002 22:55:45 +0000 (GMT)
Cc: hpa@zytor.com (H. Peter Anvin), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0203141403561.1286-100000@scsoftware.sc-software.com> from "John Heil" at Mar 14, 2002 02:06:32 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16le8P-00028c-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > It is, in fact, broken on several systems -- I tried ED in SYSLINUX
> > for a while, and it broke things for people.
> 
> It does work on many, in fact, we used on a Crusoe based platform
> as well as the other x86s
> 
> Let's make it a configurable kernel debug/hacking option else
> we have the added burden of chasing down a common address.

We've got one. Its 0x80. It works everywhere with only marginal non
problematic side effects
