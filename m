Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267079AbSLDUqD>; Wed, 4 Dec 2002 15:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267080AbSLDUqD>; Wed, 4 Dec 2002 15:46:03 -0500
Received: from windsormachine.com ([206.48.122.28]:23048 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id <S267079AbSLDUqD>; Wed, 4 Dec 2002 15:46:03 -0500
Date: Wed, 4 Dec 2002 15:53:33 -0500 (EST)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.20 on an ASUS P4B533-E(and P4B533) successfully works
Message-ID: <Pine.LNX.4.33.0212041547590.20132-100000@router.windsormachine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've seen a lot of posts about the P4B533's recently with 2.4.1[89], so I
thought I'd post a success story.

2,4.20, using the intel ethernet driver(e100.c)

Both onboard IDE controllers work in DMA mode properly at full speed
without having to do any hdparm magic.

Onboard ethernet is detected and works at 100/FD.

I don't use the RAID function of the onboard HPT, so no idea on that, I
would expect that to work though.

No -VM boards here, so no video status.

Mike

