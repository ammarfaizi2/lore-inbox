Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266995AbSLPSuE>; Mon, 16 Dec 2002 13:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267062AbSLPSs3>; Mon, 16 Dec 2002 13:48:29 -0500
Received: from windsormachine.com ([206.48.122.28]:44292 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id <S267043AbSLPSsS>; Mon, 16 Dec 2002 13:48:18 -0500
Date: Mon, 16 Dec 2002 13:56:09 -0500 (EST)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: Xavier LaRue <paxl@videotron.ca>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: L2 Cache problem
In-Reply-To: <20021216133016.64c75cac.paxl@videotron.ca>
Message-ID: <Pine.LNX.4.33.0212161347580.25857-100000@router.windsormachine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Dec 2002, Xavier LaRue wrote:

> my dmesg will be online at http://paxl.no-ip.org/~paxl/dmesg.txt if somone mind.
>
>
> Another fuzzy thing .. compiling my kernel normaly ( -j 1 ) take 30min
> and when I make it with -j 2/8/16 it take 25min, I think this is due to
> my L2 cache problem but that not normal, if somone have an idea.. I
> should be realy interested.

sounds like you've got your l2 turned off in the bios to me.

Mike

