Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265442AbUAFXGJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 18:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265443AbUAFXGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 18:06:09 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:14865 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265442AbUAFXGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 18:06:06 -0500
Date: Tue, 6 Jan 2004 23:06:04 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: S Ait-Kassi <sait-kassi@zonnet.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: [update]  Vesafb problem since 2.5.51
In-Reply-To: <200401061440.55724.sait-kassi@zonnet.nl>
Message-ID: <Pine.LNX.4.44.0401062305180.21143-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Please try my latest patch. I tested midnight commander on my system and
> > my system is okay. This is using the vesa framebuffer.
> >
> > http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz
> 
> Just tried the patch with the 2.6.0 kernel and it didn't help. As a bonus 
> "feature" the cursor also makes the character it is underlining blink.

The cursor is busted but I think the latest patch from Pavel might fix it.
 
> I assume that something broke in 2.5.51 on some cards (maybe while making 
> fb-con modular?). Three of the four people who stated they had this problem 
> had a ATI card (two had a Radeon 7500 and I have a Radeon 9500 and one didn't 
> include the videocard). :( 

What is your config?


