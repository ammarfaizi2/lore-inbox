Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314514AbSIHUTb>; Sun, 8 Sep 2002 16:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314529AbSIHUTb>; Sun, 8 Sep 2002 16:19:31 -0400
Received: from balthasar.nuitari.net ([216.40.249.34]:10413 "HELO
	nuitari.nuitari.net") by vger.kernel.org with SMTP
	id <S314514AbSIHUTa>; Sun, 8 Sep 2002 16:19:30 -0400
Date: Sun, 8 Sep 2002 22:37:11 -0400 (EDT)
From: Nuitari <nuitari@balthasar.nuitari.net>
To: linux-kernel@vger.kernel.org
Subject: Re: ide drive dying?
In-Reply-To: <200209082011.g88KBsdj004134@darkstar.example.net>
Message-ID: <Pine.LNX.4.44.0209082233150.16694-100000@balthasar.nuitari.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Sep 2002 jbradford@dial.pipex.com wrote:

> > Keep your drive cool and you can expect to keep it around for a very 
> > long time.
> 
> In a large tower case, it is worth while to leave a drive bay free between disks, instead of using them sequentially, like this:
> 
>     ------             ------
>     |****|             |****|
>     ------             ------
>     |    |             |****|
>     ------             ------
>     |****|             |****|
>     ------  instead of ------
>     |    |             |    |
>     ------             ------
>     |****|             |    |
>     ------             ------
>     |    |             |    |
>     ------             ------
> 
> Also, if you get a disk that suddenly doesn't spin up, don't assume that
> the motor has died - you can sometimes bring them back to life by
> connecting power to them, and giving them a very sharp angular jolt in
> the plane of the platters - the effect is called static friction,
> (A.K.A. stiction)


Depends on the ventilation you can put.
In this computer I have all bays (5 1/4 and 3 1/2) full and the 
temperature doesn't get over 30
There is a total of 4 HDs and 3CDs drives.

I think the spacing depends on the heat output of the drives.
I use my  2 Samsungs (they are always cold) between the Maxtor (makes a 
lot of heat) and Fujitsu.


Of course the best is to strap 6" fans in front of them (which I did to 
cool a stack of 6 full height disks that I put in an old full tower 
cases).

