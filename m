Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268439AbUH3Bym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268439AbUH3Bym (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 21:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268440AbUH3Bym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 21:54:42 -0400
Received: from mail-08.iinet.net.au ([203.59.3.40]:58571 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S268439AbUH3Byb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 21:54:31 -0400
Date: Mon, 30 Aug 2004 09:53:13 +0800 (WST)
From: Michael <quadfour@iinet.net.au>
X-X-Sender: quadfour@natalie
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8.1 OOPS, processes hanging in D state, can reproduce
In-Reply-To: <Pine.LNX.4.50.0408290951430.5632-100000@natalie>
Message-ID: <Pine.LNX.4.50.0408300924310.705-100000@natalie>
References: <Pine.LNX.4.50.0408290659030.3632-100000@natalie>
 <1093740497.7078.15.camel@krustophenia.net> <Pine.LNX.4.50.0408290951430.5632-100000@natalie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Aug 2004, Michael wrote:

> 
> On Sat, 28 Aug 2004, Lee Revell wrote:
> 
> > 
> > On Sat, 2004-08-28 at 20:25, Michael wrote:
> > > First post to the list, never found a kernel bug before :)
> > > 
> > 
> > Your kernel is tainted, probably due to having a binary module loaded. 
> > Please reproduce with an untainted kernel and repost.

I've received a howto via email on tracking down kernel oopses. I've 
followed the guide as far as I could but got stuck at the point of trying 
to find the part of asm code causing this because the 'Code' does not 
match as in the howto. I think the oops is stemming from a problem with 
the loop module but I don't know how to continue, I have not got the 
knowledge to do this.

More or less I think I've done as much as I can, I've provided as much 
information as I can about the problem. Im leaving this in the hands of 
experienced people :)

Regards
Michael Collard
