Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315481AbSGALjO>; Mon, 1 Jul 2002 07:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315483AbSGALjN>; Mon, 1 Jul 2002 07:39:13 -0400
Received: from d06lmsgate-4.uk.ibm.com ([195.212.29.4]:61671 "EHLO
	d06lmsgate-4.uk.ibm.COM") by vger.kernel.org with ESMTP
	id <S315481AbSGALjN>; Mon, 1 Jul 2002 07:39:13 -0400
Content-Type: text/plain; charset=US-ASCII
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
To: Matthew Wilcox <willy@debian.org>,
       Janitors <kernel-janitor-discuss@lists.sourceforge.net>
Subject: Re: [RFC] BH removal text
Date: Mon, 1 Jul 2002 15:41:32 +0200
User-Agent: KMail/1.4.2
Cc: linux-kernel@vger.kernel.org
References: <20020701050555.F29045@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20020701050555.F29045@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207011541.33128.arnd@bergmann-dalldorf.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 01 July 2002 06:05, Matthew Wilcox wrote:

> Of course, that's the lazy way of doing it.  What I'm hoping is that each
> Janitor will take a driver and spend a week checking over its locking.
> There's only 80 files in the kernel which use tq_immediate; with 10
> Janitors involved, that's 8 drivers each -- that's only 2 months and we
> have 4.

I suppose mine are the 8 drivers in drivers/s390 then :-). 
I'm already working on them to support the new LDM and I know the
maintainers.

	Arnd <><
