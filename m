Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287781AbSBCVpl>; Sun, 3 Feb 2002 16:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287794AbSBCVpb>; Sun, 3 Feb 2002 16:45:31 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:10509 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287781AbSBCVpR>; Sun, 3 Feb 2002 16:45:17 -0500
Subject: Re: 2.4.17 NFS hangup
To: buga+dated+1013031263.c89449@elte.hu ("=?iso-8859-2?Q?Burj=E1n_G=E1bor?=")
Date: Sun, 3 Feb 2002 21:58:26 +0000 (GMT)
Cc: trond.myklebust@fys.uio.no (Trond Myklebust),
        linux-kernel@vger.kernel.org (LKML)
In-Reply-To: <20020203213422.GA703@csoma.elte.hu> from "=?iso-8859-2?Q?Burj=E1n_G=E1bor?=" at Feb 03, 2002 10:34:22 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16XUeY-0005Pt-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Output is here: http://www.csoma.elte.hu/~burjang/netstat-s-20020203.out
> 
> I think `1710 reassemblies required' may be strange after boot...
> How can I figure out what causes this?

NFS uses large packets.
