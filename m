Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312254AbSD2N5Z>; Mon, 29 Apr 2002 09:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312253AbSD2N5Y>; Mon, 29 Apr 2002 09:57:24 -0400
Received: from windsormachine.com ([206.48.122.28]:11019 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id <S312254AbSD2N5V>; Mon, 29 Apr 2002 09:57:21 -0400
Date: Mon, 29 Apr 2002 09:57:10 -0400 (EDT)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 48-bit IDE [Re: 160gb disk showing up as 137gb]
In-Reply-To: <200204291106.NAA18202@cave.bitwizard.nl>
Message-ID: <Pine.LNX.4.33.0204290951460.27860-100000@router.windsormachine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For some reason, my 160G disks work on the "native" controllers, but
> not on the promise cards that I bought for the purpose... After
> figuring this out I haven't taken the time to find the root cause, as
> I'm just a user in this respect...
>
> 			Roger.

I seem to remember something about new Promise BIOS's that fix that
LBA48 issue.  Try updating the bios, and see what happens.

Looking at their bios page, I see the Ultra 100 TX2 supports LBA48, don't
see any info on the Ultra 100, Ultra 66, etc though.  I believe the 133
TX2 has it built in.

Hope this helps,

Mike

