Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137161AbREKQID>; Fri, 11 May 2001 12:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137163AbREKQHx>; Fri, 11 May 2001 12:07:53 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:59146 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S137161AbREKQHg>; Fri, 11 May 2001 12:07:36 -0400
Subject: Re: reiserfs, xfs, ext2, ext3
To: hps@intermeta.de
Date: Fri, 11 May 2001 17:04:10 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9dgvvn$n3h$1@forge.intermeta.de> from "Henning P. Schmiedehausen" at May 11, 2001 03:20:23 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14yFOk-0001GQ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think with the growing acceptance of ReiserFS in the Linux
> community, it is tiresome to have to apply a patch again and again
> just to get working NFS. 2.2 NFS horrors all over again.

The zero copy patches were basically self contained and tested for 6 months.
The reiserfs NFS hacks are ugly as hell and dont belong in the base kernel.
There is a difference.

Alan

