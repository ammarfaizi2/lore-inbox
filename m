Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288019AbSAXORn>; Thu, 24 Jan 2002 09:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288047AbSAXORd>; Thu, 24 Jan 2002 09:17:33 -0500
Received: from pizda.ninka.net ([216.101.162.242]:49800 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S288019AbSAXOR3>;
	Thu, 24 Jan 2002 09:17:29 -0500
Date: Thu, 24 Jan 2002 06:16:05 -0800 (PST)
Message-Id: <20020124.061605.131916581.davem@redhat.com>
To: jes@wildopensource.com
Cc: adam@yggdrasil.com, linux-acenic@sunsite.dk, linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.3-pre4/drivers/acenic.c: pci_unmap_addr_set not
 defined for x86
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15440.5902.755260.764642@trained-monkey.org>
In-Reply-To: <15440.4044.565375.681853@trained-monkey.org>
	<20020124.054626.15688749.davem@redhat.com>
	<15440.5902.755260.764642@trained-monkey.org>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jes Sorensen <jes@wildopensource.com>
   Date: Thu, 24 Jan 2002 09:15:42 -0500
   
   Considering a) it's just a few keystrokes to add a CC: line, b) it's the
   driver authors who are the first to get the bug reports, then yes it
   seems like a very reasonable request.

This list actually is the first place the reports typically
go to.

I'm a responsible maintainer, when I add a problem, I always go back
and fix it or revert my changes.  I never disappear after making
these kinds of changes.
