Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262703AbTJEOF1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 10:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263113AbTJEOF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 10:05:27 -0400
Received: from gaia.cela.pl ([213.134.162.11]:47883 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S262703AbTJEOFY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 10:05:24 -0400
Date: Sun, 5 Oct 2003 16:05:15 +0200 (CEST)
From: Maciej Zenczykowski <maze@cela.pl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swap and 2.4.20
In-Reply-To: <200310051157.h95BvwvA004385@habitrail.home.fools-errant.com>
Message-ID: <Pine.LNX.4.44.0310051559340.5605-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I remember Linus ranting about swap at one point, but it's been a while.
> 
> What is the current state of the need for swap on a linux kernel, 2.4.20 in 
> specific. Does it need *any*, given some reasonable amount of RAM? What 
> constitutes a reasonable of RAM?
> 
> My recent experience suggest none is needed.

I have a different - slightly academic - question.  Is it possible to turn
off swapping? (not turn off swap)  Ie. to prevent the kernel from
unloading paged-in read-only executables?  I realise this is a tough
question with mmap being used for many other things besides executables...

Thanks,
MaZe.

