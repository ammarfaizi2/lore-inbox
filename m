Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261817AbSJIPSC>; Wed, 9 Oct 2002 11:18:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261824AbSJIPSC>; Wed, 9 Oct 2002 11:18:02 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:10914 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261817AbSJIPR5>; Wed, 9 Oct 2002 11:17:57 -0400
Subject: Re: 2.5.41: ide-probe.c: HD_IRQ undeclared
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: ebuddington@wesleyan.edu
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021009104039.A15212@ma-northadams1b-3.nad.adelphia.net>
References: <20021009104039.A15212@ma-northadams1b-3.nad.adelphia.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 09 Oct 2002 16:34:19 +0100
Message-Id: <1034177659.2065.54.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-09 at 15:40, Eric Buddington wrote:
> This is a compile failure on 2.5.41, compiled for a PII using gcc-3.0.4.
> Just about all options configured as 'm'.

Al Viro posted a fix for this one. If you are building XFree86 kernels I
strongly recommend you use 3.1.x/3.2 or 2.9x though

