Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269194AbRHBWdM>; Thu, 2 Aug 2001 18:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269193AbRHBWdD>; Thu, 2 Aug 2001 18:33:03 -0400
Received: from w146.z064001233.sjc-ca.dsl.cnc.net ([64.1.233.146]:55727 "EHLO
	windmill.gghcwest.com") by vger.kernel.org with ESMTP
	id <S269194AbRHBWcw>; Thu, 2 Aug 2001 18:32:52 -0400
Date: Thu, 2 Aug 2001 15:32:46 -0700 (PDT)
From: "Jeffrey W. Baker" <jwbaker@acm.org>
X-X-Sender: <jwb@heat.gghcwest.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Ongoing 2.4 VM suckage
In-Reply-To: <Pine.LNX.4.33L.0108021925460.5582-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0108021532180.21298-100000@heat.gghcwest.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 2 Aug 2001, Rik van Riel wrote:

> On Thu, 2 Aug 2001, Jeffrey W. Baker wrote:
>
> > I'm telling you that's not what happens.  When memory pressure
> > gets really high, the kernel takes all the CPU time and the box
> > is completely useless. Maybe the VM sorts itself out but after
> > five minutes of barely responding, I usually just power cycle
> > the damn thing.  As I said, this isn't a classic thrash because
> > the swap disks only blip perhaps once every ten seconds!
>
> What kind of workload are you running ?
>
> We could be dealing with some weird artifact of
> virtual page scanning here, or with a strange
> side effect of recent VM changes ...

I'll try to whip up a little C program that brings down my machine.

-jwb

