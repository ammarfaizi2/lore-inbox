Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267816AbRGZM15>; Thu, 26 Jul 2001 08:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267850AbRGZM1r>; Thu, 26 Jul 2001 08:27:47 -0400
Received: from lightning.hereintown.net ([207.196.96.3]:63384 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id <S267816AbRGZM13>; Thu, 26 Jul 2001 08:27:29 -0400
Date: Thu, 26 Jul 2001 08:42:05 -0400 (EDT)
From: Chris Meadors <clubneon@hereintown.net>
To: Matthew Gardiner <kiwiunixman@yahoo.co.nz>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: DAC module in 2.4.7 buggered
In-Reply-To: <01072622285501.00924@kiwiunixman.nodomain.nowhere>
Message-ID: <Pine.LNX.4.31.0107260838450.3437-100000@rc.priv.hereintown.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thu, 26 Jul 2001, Matthew Gardiner wrote:

> I was just compiling 2.4.7 a couple of days ago, and DAC that is located in
> block devices (just below the compaq raid things in the configmenu) fails to
> compile as a module.

I'm guessing you mean the DAC960 driver.  I couldn't get it to compile
when built into the kernel either.

> I removed it, and everything went alright.
>
> Although I don't need it, I thought I might as well inform the kernel guru's
> of this error that may be affecting other users.

I do need it for 2 of my machines here.  For now I've just kept them at
2.4.6 cause that is working fine.

-Chris
-- 
Two penguins were walking on an iceberg.  The first penguin said to the
second, "you look like you are wearing a tuxedo."  The second penguin
said, "I might be..."                         --David Lynch, Twin Peaks

