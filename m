Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274789AbRJAI71>; Mon, 1 Oct 2001 04:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274791AbRJAI7Q>; Mon, 1 Oct 2001 04:59:16 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:9227 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274789AbRJAI7F>; Mon, 1 Oct 2001 04:59:05 -0400
Subject: Re: Linux 2.4.10-ac1
To: kaos@ocs.com.au (Keith Owens)
Date: Mon, 1 Oct 2001 10:03:24 +0100 (BST)
Cc: laughing@shared-source.org (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <17878.1001905834@kao2.melbourne.sgi.com> from "Keith Owens" at Oct 01, 2001 01:10:34 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15nyyy-0000gk-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 1 Oct 2001 00:15:19 +0100, 
> Alan Cox <laughing@shared-source.org> wrote:
> >2.4.10-ac1
> >o	Merge with Linux 2.4.10 tree
> 
> You deleted include/linux/rbtree.h, lib/rbtree.c and include/asm-s390/tlb.h
> from Linus's tree.  I doubt that was deliberate.

rbtree is not used in the -ac kernel. Its part of the VM changes. As to
tlb.h - that I'll double check

