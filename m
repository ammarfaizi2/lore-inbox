Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317683AbSGJXrd>; Wed, 10 Jul 2002 19:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317685AbSGJXrd>; Wed, 10 Jul 2002 19:47:33 -0400
Received: from ns1.system-techniques.com ([199.33.245.254]:21656 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S317683AbSGJXrb>; Wed, 10 Jul 2002 19:47:31 -0400
Date: Wed, 10 Jul 2002 19:49:33 -0400 (EDT)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Mukesh Rajan <mrajan@ics.uci.edu>
cc: kobras@tat.physik.uni-tuebingen.de,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: HDD test bench
In-Reply-To: <Pine.SOL.4.20.0207101636590.10900-100000@hobbit.ics.uci.edu>
Message-ID: <Pine.LNX.4.44.0207101948100.5583-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello Mukesh ,  This is one that Benno Senoner <sbenno@gardena.net>
	announced to the linux-fsdevel list some time back .  Hth ,  JimL

http://www.linuxdj.com/hdrbench

On Wed, 10 Jul 2002, Mukesh Rajan wrote:

> hi,
>
> i am currently exploring some power optimization algorithm for HDs
> exploiting multiple power states.
>
> i am looking for suggestions to generate a test bench simulating user
> activity. i will have to open and read/write to files on the basis of a
> trace file. currently i'm doing it in a very ad hoc fashion. i have some
> 100 dummy files of varying sizes and generating random read/write
> requests. any better way would be appreciated.
>
> thanks,
> mukesh
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+


