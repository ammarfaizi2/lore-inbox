Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285394AbRLGDYn>; Thu, 6 Dec 2001 22:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285397AbRLGDYa>; Thu, 6 Dec 2001 22:24:30 -0500
Received: from hall.mail.mindspring.net ([207.69.200.60]:49703 "EHLO
	hall.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S285394AbRLGDYS>; Thu, 6 Dec 2001 22:24:18 -0500
Message-ID: <3C103791.77D6EC01@mindspring.com>
Date: Thu, 06 Dec 2001 19:29:21 -0800
From: Joe <joeja@mindspring.com>
Reply-To: joeja@mindspring.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: Paul Bristow <paul@paulbristow.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.x 2.5.x wishlist
In-Reply-To: <Pine.LNX.4.10.10112061433100.15265-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:

> > Damn.  Lost interrupt is outside my code.  This lives in the ide driver
> > proper and is probably relative toi the via82cxxx specific controller
> > code that is deep voodoo from Andre.  I guess Andre/Jens have not found
> > all the *funnies* in the buggy chipset.
>
> Paul I have to finish a packet_taskfile_ioctl for seeing if we have to
> correct data-transport rules in place.  For the longest time it has been a
> pig in a poke.  The ATAPI diagnostics toolkit will be significantly
> tougher but still doable.

that's why I am hoping to get it into the wish list for 2.5...

