Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132584AbRDEJX3>; Thu, 5 Apr 2001 05:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132585AbRDEJXT>; Thu, 5 Apr 2001 05:23:19 -0400
Received: from postfix2-2.free.fr ([213.228.0.140]:14352 "HELO
	postfix2-2.free.fr") by vger.kernel.org with SMTP
	id <S132584AbRDEJXO>; Thu, 5 Apr 2001 05:23:14 -0400
Message-Id: <5.0.0.25.2.20010405112016.02f35470@pop.free.fr>
X-Mailer: QUALCOMM Windows Eudora Version 5.0
Date: Thu, 05 Apr 2001 11:23:05 +0200
To: alad@hss.hns.com, linux-kernel@vger.kernel.org
From: dantes@free.fr
Subject: Re: Release naming conventions
In-Reply-To: <65256A25.002CC590.00@sandesh.hss.hns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 13:46 05/04/01 +0530, alad@hss.hns.com wrote:

>well..don't fire me for asking such a stupid question... I am new to linux
>kernel world...

Welcome on board!

>I want to know the release naming conventions in linux..
>I know the following...
>2.1.xx --> means developmet release
>2.2.xx --> means stable release...

OK for now.

>Now what 2.2.xx-pre6 or 2.2.xx-ac3 means ??

The 2.2.XX-preY pre kernels are basically pre-releases, which means getting 
fairly close (except for a few bugs) to the 2.2.XX kernel. Of course, the 
highest the Y the closest to the release, and this applies to other 
branches, such as 2.4.
The 2.2.XX-acY are the "Alan Cox releases". All the patches submitted to 
this list are merged by Alan, then released as patches (you can get them 
from ftp.KK.kernel.org/pub/linux/kernel/people/alan/2.2 or 2.4, where KK if 
your country code {uk|de|fr|whatever}). They can be considered as some sort 
of intermediate steps between two releases, although some of the patches 
may not be included in the next release, for different reasons. The current 
one for the 2.4 branch is the 2.4.3-ac2.

>Amol

Best regards
Dantes

