Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130507AbRD3SHr>; Mon, 30 Apr 2001 14:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133007AbRD3SHh>; Mon, 30 Apr 2001 14:07:37 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:14601 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130507AbRD3SH0>; Mon, 30 Apr 2001 14:07:26 -0400
Subject: Re: buz.c of 2.4.4
To: jinbo21@hananet.net
Date: Mon, 30 Apr 2001 19:08:57 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0104290210480.581-100000@progress.plw.net> from "Byeong-ryeol Kim" at Apr 29, 2001 02:23:37 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14uI6W-0008Kl-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I met follwing erros which was workarounded by put
> define KMALLOC_MAXSIZE	131072
> borrowed from af_unix.c of 2.4.3-ac14. But I'm convinced of this.
> below lines were wrapped by me for readabilities' sake.

Buz.c doesnt work build or anything. Once the zoran merge is done it will
go away, until then I simply dont care.  At least its obviously broken right
now

