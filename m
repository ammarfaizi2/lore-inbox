Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269988AbRHESng>; Sun, 5 Aug 2001 14:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269986AbRHESn0>; Sun, 5 Aug 2001 14:43:26 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:52492 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269988AbRHESnS>; Sun, 5 Aug 2001 14:43:18 -0400
Subject: Re: Problem with ASUS CUV4X-D board
To: alan@clueserver.org
Date: Sun, 5 Aug 2001 19:45:18 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <20010805194247.190906E42@clueserver.org> from "Alan" at Aug 05, 2001 10:27:34 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15TStq-0008Bh-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I tried to find info on the web on this and was not ver successful.  (This is 
> at a friend's house.  He is out in the middle on nowhere and is lucky if he 
> get 28.8k connections.)
> 
> It this one of the non-correctable VIA chipsets?  Is there a workaround for 
> this?

The messages about correcting the clock are themselves ok - they will fix
the problem up. It seems to be specific to some VIA firmware. Initially I
thought it might be hardware but it looks like certain SMM events sometimes
corrupt the clock configuration sending it wild

Alan
