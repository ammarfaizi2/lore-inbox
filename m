Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316487AbSEOUMw>; Wed, 15 May 2002 16:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316491AbSEOULn>; Wed, 15 May 2002 16:11:43 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:9735 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316493AbSEOULU>; Wed, 15 May 2002 16:11:20 -0400
Subject: Re: [RFC] ext2 and ext3 block reservations can be bypassed
To: pavel@ucw.cz (Pavel Machek)
Date: Wed, 15 May 2002 21:29:49 +0100 (BST)
Cc: elladan@eskimo.com (Elladan), linux-kernel@vger.kernel.org (kernel list)
In-Reply-To: <20020515194857.GA6485@elf.ucw.cz> from "Pavel Machek" at May 15, 2002 09:48:58 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1785PC-0002hn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > If this is not a security feature, Documentation/filesystems/ext2.txt
> > needs to be changed.  Eg., 
> 
> I'd suggest you to mail to bugtraq@securityfocus.com; it sounds like
> security hole to me, and probably common across many unix variants.

The original Unix documentation for FFS refers to it only as a performance
oriented reason.

Alan
