Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269014AbRHBQEK>; Thu, 2 Aug 2001 12:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269021AbRHBQEA>; Thu, 2 Aug 2001 12:04:00 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:58815 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S269014AbRHBQD4>; Thu, 2 Aug 2001 12:03:56 -0400
Date: Thu, 2 Aug 2001 17:05:07 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Chris Vandomelen <chrisv@b0rked.dhs.org>,
        Nerijus Baliunas <nerijus@users.sourceforge.net>,
        Guest section DW <dwguest@win.tue.nl>, linux-kernel@vger.kernel.org
Subject: Re: Re[2]: cannot copy files larger than 40 MB from CD
In-Reply-To: <E15SKBL-0000qt-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0108021657540.6526-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Aug 2001, Alan Cox wrote:
> egcs-1.1.2 aka kgcc wont build 2.4.7 it seems. gcc 2.96 >= 2.96.75 or so is
> just fine, gcc 2.95-2/3 is fine, gcc 3.0 seems to be doing the right thing

I've seen no problem running 2.4.7 built with egcs-1.1.2 2.91.66:
which part of it is believed not to build or to build wrongly?
(arch/i386/kernel/traps.c errors were identified as old binutils.)

Hugh

