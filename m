Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286978AbRL1Sj4>; Fri, 28 Dec 2001 13:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286976AbRL1Sjq>; Fri, 28 Dec 2001 13:39:46 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:11 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286982AbRL1Sjh>; Fri, 28 Dec 2001 13:39:37 -0500
Subject: Re: [RFC][PATCH] unchecked request_region's in drivers/net
To: rhw@MemAlpha.cx
Date: Fri, 28 Dec 2001 18:48:54 +0000 (GMT)
Cc: adilger@turbolabs.com (Andreas Dilger),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <Pine.LNX.4.21.0112281810330.3044-100000@Consulate.UFP.CX> from "Riley Williams" at Dec 28, 2001 06:34:16 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16K23q-0001OG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> currently is, but add a PATCHES-TO file in each subdirectory that
> states how to handle patches relating to that directory, and have
> these files follow a strict format, possibly...

Add the patches to to the maintainers as another field. If the patches
go to someone who isnt claiming to be a maintainer something is wrong
