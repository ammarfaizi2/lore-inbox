Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135284AbRDLTm4>; Thu, 12 Apr 2001 15:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135271AbRDLTmX>; Thu, 12 Apr 2001 15:42:23 -0400
Received: from lightning.hereintown.net ([207.196.96.3]:7057 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id <S135281AbRDLTkX>; Thu, 12 Apr 2001 15:40:23 -0400
Date: Thu, 12 Apr 2001 15:53:27 -0400 (EDT)
From: Chris Meadors <clubneon@hereintown.net>
To: "thunder7@xs4all.nl" <thunder7@xs4all.nl>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [lkml]Re: [PATCH] matroxfb and mga XF4 driver coexistence...
In-Reply-To: <20010412205303.A20394@middle.of.nowhere>
Message-ID: <Pine.LNX.4.31.0104121546340.15715-100000@rc.priv.hereintown.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Apr 2001, thunder7@xs4all.nl wrote:

> Of course, but if we can fix the problem by making the kernel smaller,
> what possible motive could you have for opposing it other than 'but it
> doesn't solve _my_ problems!' ?

Agreed.  The only thing I was thinking, was if the kernel is doing the
right thing now, it shouldn't be forced to work around a bug in XFree.
By not "fixing" the kernel, the XFree team would be forced to do the right
thing.

As for me, I'm going to see about getting the matroxfb working, so if the
patch goes in I'll be able to use a nice 132 character wide terminal
again.  And I'm getting addicted to dual head in X, might be fun on the
console too.

-Chris
-- 
Two penguins were walking on an iceberg.  The first penguin said to the
second, "you look like you are wearing a tuxedo."  The second penguin
said, "I might be..."                         --David Lynch, Twin Peaks

