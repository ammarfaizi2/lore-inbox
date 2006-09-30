Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751021AbWI3OVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbWI3OVf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 10:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751019AbWI3OVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 10:21:35 -0400
Received: from 1wt.eu ([62.212.114.60]:33299 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1751014AbWI3OVe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 10:21:34 -0400
Date: Sat, 30 Sep 2006 15:51:22 +0200
From: Willy Tarreau <w@1wt.eu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Frederik Deweerdt <deweerdt@free.fr>, Matthew Wilcox <matthew@wil.cx>,
       "J.A. Magall??n" <jamagallon@ono.com>, Andrew Morton <akpm@osdl.org>,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org
Subject: Re: [-mm patch] aic7xxx: check irq validity (was Re: 2.6.18-mm2)
Message-ID: <20060930135122.GP541@1wt.eu>
References: <20060928014623.ccc9b885.akpm@osdl.org> <20060929155738.7076f0c8@werewolf> <20060929143949.GL5017@parisc-linux.org> <1159550143.13029.36.camel@localhost.localdomain> <20060929235054.GB2020@slug> <1159573404.13029.96.camel@localhost.localdomain> <20060930140946.GA1195@slug> <1159625954.13029.136.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159625954.13029.136.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 30, 2006 at 03:19:14PM +0100, Alan Cox wrote:
> Ar Sad, 2006-09-30 am 14:09 +0000, ysgrifennodd Frederik Deweerdt:
> > Signed-off-by: Frederik Deweerdt <frederik.deweerdt@gmail.com>
> 
> Acked-by: Alan Cox <alan@redhat.com>

It seems to me that it's also valid for 2.4. Has someone any objection ?

Willy

