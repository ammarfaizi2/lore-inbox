Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291531AbSB0UQz>; Wed, 27 Feb 2002 15:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292928AbSB0UQd>; Wed, 27 Feb 2002 15:16:33 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:9488 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292927AbSB0UQL>; Wed, 27 Feb 2002 15:16:11 -0500
Subject: Re: Big file support
To: barubary@cox.net (Barubary)
Date: Wed, 27 Feb 2002 20:31:02 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, rstevens@vitalstream.com (Rick Stevens)
In-Reply-To: <006301c1bfc9$a5c6de90$a7eb0544@CX535256D> from "Barubary" at Feb 27, 2002 12:02:12 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16gAj8-0005kb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A lot of the kernel supports big files already.  The real problem is the
> fact that the primary Linux file system, ext3, does not.  If you use some
> file system besides ext3, big files should work.

This is incorrect information. Ext3 supports large files. Whoever told
you otherwise was wrong.
