Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261893AbREPMLe>; Wed, 16 May 2001 08:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261894AbREPMLO>; Wed, 16 May 2001 08:11:14 -0400
Received: from lightning.hereintown.net ([207.196.96.3]:40324 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id <S261893AbREPMLK>; Wed, 16 May 2001 08:11:10 -0400
Date: Wed, 16 May 2001 08:24:11 -0400 (EDT)
From: Chris Meadors <clubneon@hereintown.net>
To: Anuradha Ratnaweera <anuradha@bee.lk>
cc: "Jorge Boncompte [DTI2]" <jorge@dti2.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.2 - Locked keyboard
In-Reply-To: <Pine.LNX.4.21.0105151953150.302-100000@presario>
Message-ID: <Pine.LNX.4.31.0105160820250.7059-100000@rc.priv.hereintown.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 May 2001, Anuradha Ratnaweera wrote:

>
> On Thu, 10 May 2001, Jorge Boncompte [DTI2] wrote:
>
> > After the reboot, the keyboard was working 5 minutes and then it
> > locked. The console was working. I rebooted the machine again and has
> > been working for 2 days, that the keyboard gets locked again.
>
> Just to make sure...
>
> Did you check scoll lock? :)

I was seeing the same problem in 2.4.0-2.  Unplugging my keyboard for a
few seconds and then plugging it back in would solve it when it happened,
but it would happen again.

2.4.3 seemed to have the problem decrease, and I don't think I've seen it
once with 2.4.4.

So someone seemed to have known about it and was working to fix it.

-Chris
-- 
Two penguins were walking on an iceberg.  The first penguin said to the
second, "you look like you are wearing a tuxedo."  The second penguin
said, "I might be..."                         --David Lynch, Twin Peaks

