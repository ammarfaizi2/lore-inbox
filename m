Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315739AbSENOcC>; Tue, 14 May 2002 10:32:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315742AbSENOcC>; Tue, 14 May 2002 10:32:02 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:29445 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315739AbSENOcB>; Tue, 14 May 2002 10:32:01 -0400
Subject: Re: 2.4.19-pre8 != bk -rv2.4.19-pre8
To: andrea.gelmini@linux.it (andrea gelmini)
Date: Tue, 14 May 2002 15:51:49 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020514134836.GA8261@fondoweb.net> from "andrea gelmini" at May 14, 2002 03:48:36 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E177deX-00084Y-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	'diff -r' between 2.4.19-pre8 downloaded from ftp.kernel.org and
> 	the same version extracted from bitkeeper (parent is
> 	bk://linux.bkbits.net/linux-2.4), produce the follow diff. it's
> 	not a big issue, but it's a little annoying to apply -ac
> 	patches.

If the bitkeeper tree differs from the official tarball the bitkeeper
tree you are using is either not 2.4.19-pre8 proper, or its broken.


