Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313563AbSECOc4>; Fri, 3 May 2002 10:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313578AbSECOcz>; Fri, 3 May 2002 10:32:55 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:54793 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313563AbSECOcz>; Fri, 3 May 2002 10:32:55 -0400
Subject: Re: kernel strangeness
To: skmail@mcewen.wcnet.org
Date: Fri, 3 May 2002 15:51:56 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0205031009100.24533-100000@mcewen.wcnet.org> from "skmail@mcewen.wcnet.org" at May 03, 2002 10:11:18 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E173ePc-0006Uu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thank you.  I will try replacing the glibc.  If I understand right (I'm 
> not a programmer) I will need to recompile the kernel, and possibly some 
> other programs, against the i386 glibc.  Correct?

You don't. You just need to replace the i686 rpm of glibc with the i386 one
and all should be well

