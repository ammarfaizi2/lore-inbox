Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264907AbSKNPCi>; Thu, 14 Nov 2002 10:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264915AbSKNPCi>; Thu, 14 Nov 2002 10:02:38 -0500
Received: from windsormachine.com ([206.48.122.28]:63751 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id <S264907AbSKNPCh>; Thu, 14 Nov 2002 10:02:37 -0500
Date: Thu, 14 Nov 2002 10:09:24 -0500 (EST)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: Jani Averbach <jaa@cc.jyu.fi>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: How do I re-activate IDE controller (secondary channel) after
 boot?
In-Reply-To: <Pine.GSO.4.33.0211141655040.19612-100000@tukki.cc.jyu.fi>
Message-ID: <Pine.LNX.4.33.0211141008480.10843-100000@router.windsormachine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Nov 2002, Jani Averbach wrote:

> On Thu, 14 Nov 2002, Mike Dresser wrote:
>
> > Don't disable the ide channel, set the hard drive type to none in the
> > bios, instead of auto.
>
> It was set to none. I emphazise that bios will halt if drive is connected
> in 80G mode, regardless of bios setting (Disabling ide-2 will help,
> however).
>
> I have found 3 different way to boot machine with this hd so far:
> 1) jumpper drive to 32G mode
> 2) disable ide-2 channel
> 3) don't connect disk's cables at all. =)

Very odd BIOS, but that's a given.  What happens in case #1?  I thought I
remembered a way to get the full capacity after Linux has booted up, using
that method.

Mike

