Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131144AbRBMWTT>; Tue, 13 Feb 2001 17:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131273AbRBMWTJ>; Tue, 13 Feb 2001 17:19:09 -0500
Received: from snowbird.megapath.net ([216.200.176.7]:21007 "EHLO
	megapathdsl.net") by vger.kernel.org with ESMTP id <S131144AbRBMWSz>;
	Tue, 13 Feb 2001 17:18:55 -0500
Subject: Re: Will the IBM OMNI printer driver be making its way into the
	kernel tree?
From: Miles Lane <miles@megapathdsl.net>
To: timw@splhi.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010213140512.A8339@kochanski.internal.splhi.com>
In-Reply-To: <auto-000013960967@megapathdsl.net> 
	<20010213140512.A8339@kochanski.internal.splhi.com>
Content-Type: text/plain
X-Mailer: Evolution (0.8/+cvs.2001.02.13.10.24 - Preview Release)
Date: 13 Feb 2001 14:18:43 -0800
Mime-Version: 1.0
Message-ID: <auto-000013965666@megapathdsl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Whoops.

The reason I asked about inclusion is that printing is one of the areas
that Linux seems to struggle in terms of usability and I thought perhaps
it would make sense to modular print drivers in the kernel tree.  Since 
the OMNI driver is ghostscript-based, including it in the kernel is
obviously a bogus idea.  Sorry for missing the obvious.

I do wonder if there are no print drivers that would make sense in the
kernel tree.  After all, we have USB device drivers in the tree,
including
scanners, which aren't all that different from printers, are they?

I apologize in advance if I am just being incredibly stupid about this.

    Miles

