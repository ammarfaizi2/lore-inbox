Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275012AbRJYPib>; Thu, 25 Oct 2001 11:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275097AbRJYPiU>; Thu, 25 Oct 2001 11:38:20 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:52240 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S275012AbRJYPiD>; Thu, 25 Oct 2001 11:38:03 -0400
Subject: Re: kernel compiler
To: weber@nyc.rr.com (John Weber)
Date: Thu, 25 Oct 2001 16:45:03 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BD82DC0.7697B1AF@nyc.rr.com> from "John Weber" at Oct 25, 2001 11:20:32 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15wmgp-0005E8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > At the moment, gcc3 doesn't work too well with the kernel, and you won't
> > get any large benefit.
> 
> I use gcc3 to compile anything and everything I need.  With the
> exception of "multi-line literal complaints", my kernel compiles fine.
> 
> Is there anything that I should know?

Mostly that gcc 3.0 generally produces slower code. I've had a couple of 
noticed glitches with -ac but those have workarounds in the tree now
