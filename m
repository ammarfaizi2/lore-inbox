Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262404AbSI2Gv6>; Sun, 29 Sep 2002 02:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262405AbSI2Gv6>; Sun, 29 Sep 2002 02:51:58 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:64010
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S262404AbSI2Gv6>; Sun, 29 Sep 2002 02:51:58 -0400
Date: Sat, 28 Sep 2002 23:55:32 -0700 (PDT)
From: Andre Hedrick <andre@serialata.org>
To: james <jdickens@ameritech.net>
cc: Linus Torvalds <torvalds@transmeta.com>, Ingo Molnar <mingo@elte.hu>,
       Jeff Garzik <jgarzik@pobox.com>, Larry Kessler <kessler@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       "Andrew V. Savochkin" <saw@saw.sw.com.sg>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Richard J Moore <richardj_moore@uk.ibm.com>
Subject: Re: v2.6 vs v3.0
In-Reply-To: <200209290114.15994.jdickens@ameritech.net>
Message-ID: <Pine.LNX.4.10.10209282352110.13669-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Sep 2002, james wrote:

> How many people are sitting on the sidelines waiting for guarantee that ide is 
> not going to blow up on our filesystems and take our data with it. Guarantee 
> that ide is working and not dangerous to our data, then I bet a lot more 
> people will come back and bang on 2.5. 
> 
> I know this whole ide mess have taken me away from the devolemental series. 
> And I bet a lot of others. 

Your points are noted and taken, and once AC and I bang out the details in
2.4-ac series they are easily brought forward.  I am staying off 2.5
until I can ramp back up the learning curve on the changing API's.

I really do not want to go in and change what Jens has port forwarded
until I have a complete grasp again.  There are no more major changes at
this point and only delta's as needed to constrain concerns.

The only change could be the addition of SATA II support as soon as I
receive the WG's documents.

Cheers,

Andre Hedrick
Linux Serial ATA Solutions
LAD Storage Consulting Group

