Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314546AbSEBPJm>; Thu, 2 May 2002 11:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314549AbSEBPJl>; Thu, 2 May 2002 11:09:41 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:4876 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314546AbSEBPJi>; Thu, 2 May 2002 11:09:38 -0400
Subject: Re: RARP server support on Linux 2.4
To: burkejarlath@eircom.net (Jarlath Burke)
Date: Thu, 2 May 2002 16:28:32 +0100 (BST)
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <000701c1f1e8$739cff20$a07fa8c0@mofo> from "Jarlath Burke" at May 02, 2002 03:48:41 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E173IVU-00049w-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there any way to monitor what the kernel has
> in it's rarp cache, similiar to running the rarp command
> on the old 2.2.x kernels?

cat /dev/null

[The kernel doesn't have a rarp cache now either. Its all handled by the
 user space]
