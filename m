Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269029AbRHBWFm>; Thu, 2 Aug 2001 18:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269177AbRHBWFc>; Thu, 2 Aug 2001 18:05:32 -0400
Received: from w146.z064001233.sjc-ca.dsl.cnc.net ([64.1.233.146]:46222 "EHLO
	windmill.gghcwest.com") by vger.kernel.org with ESMTP
	id <S269029AbRHBWF1>; Thu, 2 Aug 2001 18:05:27 -0400
Date: Thu, 2 Aug 2001 15:05:27 -0700 (PDT)
From: "Jeffrey W. Baker" <jwbaker@acm.org>
X-X-Sender: <jwb@heat.gghcwest.com>
To: Miles Lane <miles@megapathdsl.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Ongoing 2.4 VM suckage
In-Reply-To: <996789389.12934.25.camel@stomata.megapathdsl.net>
Message-ID: <Pine.LNX.4.33.0108021504160.21298-100000@heat.gghcwest.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 2 Aug 2001, Miles Lane wrote:

> Hmm.  What about the OOM process killer?  Shouldn't that kick in?

You'd think so!  Maybe it stepped in and killed the kernel :)  You can't
get any information out of the machine in this state because it isn't
classic thrashing: the disks aren't running, and regular processes are
getting run VERY infrequently.

-jwb

