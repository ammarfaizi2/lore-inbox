Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288127AbSAXOoB>; Thu, 24 Jan 2002 09:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288158AbSAXOnw>; Thu, 24 Jan 2002 09:43:52 -0500
Received: from trained-monkey.org ([209.217.122.11]:12808 "EHLO
	trained-monkey.org") by vger.kernel.org with ESMTP
	id <S288127AbSAXOnk>; Thu, 24 Jan 2002 09:43:40 -0500
From: Jes Sorensen <jes@wildopensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15440.7576.636899.378071@trained-monkey.org>
Date: Thu, 24 Jan 2002 09:43:36 -0500
To: "David S. Miller" <davem@redhat.com>
Cc: adam@yggdrasil.com, linux-acenic@sunsite.dk, linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.3-pre4/drivers/acenic.c: pci_unmap_addr_set not
 defined for x86
In-Reply-To: <20020124.061605.131916581.davem@redhat.com>
In-Reply-To: <15440.4044.565375.681853@trained-monkey.org>
	<20020124.054626.15688749.davem@redhat.com>
	<15440.5902.755260.764642@trained-monkey.org>
	<20020124.061605.131916581.davem@redhat.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David S Miller <davem@redhat.com> writes:

David>    From: Jes Sorensen <jes@wildopensource.com> Date: Thu, 24 Jan
David> 2002 09:15:42 -0500
   
>    Considering a) it's just a few keystrokes to add a CC: line,
> b) it's the driver authors who are the first to get the bug
> reports, then yes it seems like a very reasonable request.

David> This list actually is the first place the reports typically go
David> to.

Actually thats not the case in my experience, very often thing like that
go to the driver specific mailing lists or the driver maintainer in
private email. In fact this more common than a report going
linux-kernel.

David> I'm a responsible maintainer, when I add a problem, I always go
David> back and fix it or revert my changes.  I never disappear after
David> making these kinds of changes.

I never claimed you don't, but some reports you never receive.

All I am suggesting is a CC, no fairytales or other stories to go with
it that actually takes time to write.

Jes
