Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262316AbTFTOVh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 10:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbTFTOVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 10:21:37 -0400
Received: from windsormachine.com ([206.48.122.28]:47108 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id S262316AbTFTOVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 10:21:35 -0400
Date: Fri, 20 Jun 2003 10:35:22 -0400 (EDT)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: xircom card bus with 2.4.20 link trouble
In-Reply-To: <1056119306.6727.27.camel@portable>
Message-ID: <Pine.LNX.4.33.0306201031160.15589-100000@router.windsormachine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Jun 2003, Arnaud Ligot wrote:

> > I haven't tried a 2.5.x kernel, nor a 2.4.21(it's on my list of things to
> > do)
> the card works with 2.4.20 nice and works if you set an ip address with
> the 2.4.21

Going to move to 2.4.21 in a few minutes(just booting up the laptop so i
can copy the vmlinuz image over to it)

> I have a CEM56-100
>

> I use the xirc2ps_cs module. I haven't force cardmgr to use so I think
> it's the good module for the card

If it's a CEM56-100, that's not a cardbus card!

That's the regular pcmcia version.  That would explain why your xirc2ps_cs
is working.  You have the same card as I do, with a differing model name.
Never did figure out what's different between the REM and CEM.

Mike

