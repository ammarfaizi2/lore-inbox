Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288012AbSAXOQE>; Thu, 24 Jan 2002 09:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288019AbSAXOPx>; Thu, 24 Jan 2002 09:15:53 -0500
Received: from trained-monkey.org ([209.217.122.11]:10760 "EHLO
	trained-monkey.org") by vger.kernel.org with ESMTP
	id <S288012AbSAXOPq>; Thu, 24 Jan 2002 09:15:46 -0500
From: Jes Sorensen <jes@wildopensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15440.5902.755260.764642@trained-monkey.org>
Date: Thu, 24 Jan 2002 09:15:42 -0500
To: "David S. Miller" <davem@redhat.com>
Cc: adam@yggdrasil.com, linux-acenic@sunsite.dk, linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.3-pre4/drivers/acenic.c: pci_unmap_addr_set not
 defined for x86
In-Reply-To: <20020124.054626.15688749.davem@redhat.com>
In-Reply-To: <200201241001.CAA00304@baldur.yggdrasil.com>
	<15440.4044.565375.681853@trained-monkey.org>
	<20020124.054626.15688749.davem@redhat.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David S Miller <davem@redhat.com> writes:

>    From: Jes Sorensen <jes@wildopensource.com> Date: Thu, 24 Jan
> 2002 08:44:44 -0500
   
>    I haven't had a chance to look at it yet. The patch wasn't
> done by me and whoever submitted it didn't seem to think it was
> worth the effort of Cc'ing me a copy of it ;-(

David> I was changing APIs, do I have to CC: every driver author on the
David> planet when I do this?

Considering a) it's just a few keystrokes to add a CC: line, b) it's the
driver authors who are the first to get the bug reports, then yes it
seems like a very reasonable request.

Jes
