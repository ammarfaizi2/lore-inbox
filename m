Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314391AbSDRQ0S>; Thu, 18 Apr 2002 12:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314392AbSDRQ0R>; Thu, 18 Apr 2002 12:26:17 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:37905 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314391AbSDRQ0Q>; Thu, 18 Apr 2002 12:26:16 -0400
Subject: Re: Linux on s/390 is cute
To: linux-kernel@borntraeger.net (Christian=?iso-8859-1?q?Borntr=E4ger?=)
Date: Thu, 18 Apr 2002 17:44:11 +0100 (BST)
Cc: lm@bitmover.com (Larry McVoy), linux-kernel@vger.kernel.org
In-Reply-To: <200204181746.30992.linux-kernel@borntraeger.net> from "Christian=?iso-8859-1?q?Borntr=E4ger?=" at Apr 18, 2002 05:46:30 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16yF11-00053J-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I'd really like to see the IBM guys let the walls between the linux
> > instances down a bit.  If I could mmap the other linux instances
> 
> I guess the wall between the images is more an advantage than a disadvantage. 
> And for sharing information between the images you have virtual network 
> drivers IUCV (VM) or hypersockets(LPAR) with a theoretical bandwith up to 
> 24Gbyte/sec for hypersockets.

Some experimenting had been done with GFS across S/390 instances apparently
