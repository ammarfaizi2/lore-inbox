Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314403AbSEXODe>; Fri, 24 May 2002 10:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314411AbSEXODd>; Fri, 24 May 2002 10:03:33 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:40459 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314403AbSEXODd>; Fri, 24 May 2002 10:03:33 -0400
Subject: Re: Nforce chipset and 2.2 kernels
To: tschenk@origin.ea.com (Thomas Schenk)
Date: Fri, 24 May 2002 15:24:01 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (LKML)
In-Reply-To: <1022203781.13260.101.camel@bagend.origin.ea.com> from "Thomas Schenk" at May 23, 2002 08:29:36 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17BFz7-0006Hg-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the Nforce 420 chipset and was wondering if there is any possibility of
> getting the integrated network component working with a 2.2.x kernel. 
> Upgrading to a 2.4.x kernel is not an option.  Any pointers would be
> appreciated.

The Nforce is basically completely unsupported by 2.2. It is mostly unsupported
by 2.4. The networking built into the chipset is not supported by either
system. Basically its windows computer
