Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274505AbRJADKp>; Sun, 30 Sep 2001 23:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274506AbRJADKf>; Sun, 30 Sep 2001 23:10:35 -0400
Received: from rj.sgi.com ([204.94.215.100]:65175 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S274505AbRJADKZ>;
	Sun, 30 Sep 2001 23:10:25 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Alan Cox <laughing@shared-source.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.10-ac1 
In-Reply-To: Your message of "Mon, 01 Oct 2001 00:15:19 +0100."
             <20011001001519.A30470@lightning.swansea.linux.org.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 01 Oct 2001 13:10:34 +1000
Message-ID: <17878.1001905834@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Oct 2001 00:15:19 +0100, 
Alan Cox <laughing@shared-source.org> wrote:
>2.4.10-ac1
>o	Merge with Linux 2.4.10 tree

You deleted include/linux/rbtree.h, lib/rbtree.c and include/asm-s390/tlb.h
from Linus's tree.  I doubt that was deliberate.

