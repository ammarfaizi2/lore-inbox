Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262782AbSI2Pxn>; Sun, 29 Sep 2002 11:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262783AbSI2Pxn>; Sun, 29 Sep 2002 11:53:43 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:9000 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id <S262782AbSI2Pxn>; Sun, 29 Sep 2002 11:53:43 -0400
Subject: Re: v2.6 vs v3.0
From: "Trever L. Adams" <tadams-lists@myrealbox.com>
To: Jens Axboe <axboe@suse.de>
Cc: james <jdickens@ameritech.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020929154516.GE1014@suse.de>
References: <Pine.LNX.4.44.0209281826050.2198-100000@home.transmeta.com>
	 <200209290114.15994.jdickens@ameritech.net>
	 <1033312735.1326.3.camel@aurora.localdomain>
	 <20020929154516.GE1014@suse.de>
Content-Type: text/plain
Organization: 
Message-Id: <1033315176.1310.10.camel@aurora.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1 (Preview Release)
Date: 29 Sep 2002 11:59:36 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-09-29 at 11:45, Jens Axboe wrote:
> How many accounts of the new block layer corrupting data have you been
> aware of? Since 2.5.1-preX when bio was introduced, I know of one such
> bug: floppy, due to the partial completion changes. Hardly critical.
> 
> -- 
> Jens Axboe

Sorry Jens, I never meant to imply I had heard of any since that floppy
bug.  I just understand there were some problems at the beginning. 
Also, I haven't been able to follow LKM as well as I would have liked
lately, but a few months ago, in one of the many IDE bash sessions that
have happened in 2.5.x I read a few people blaiming some of the problems
on interactions between the new block layer and the IDE layer.

Sorry about the worries.  I am just trying to be cautious.  I am
guessing you are saying that the block layer is now solid?   If this is
the case, it sure knocks a few of my worries out of the ball park and I
will be that much closer to trying out 2.5.x myself.

Trever ADams

