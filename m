Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135763AbRAUIFp>; Sun, 21 Jan 2001 03:05:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135806AbRAUIFg>; Sun, 21 Jan 2001 03:05:36 -0500
Received: from p3EE3CA27.dip.t-dialin.net ([62.227.202.39]:4868 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S135763AbRAUIFa>; Sun, 21 Jan 2001 03:05:30 -0500
Date: Sun, 21 Jan 2001 03:00:05 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Coding Style
Message-ID: <20010121030005.B4626@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3A68809B.E12EF3D9@purplecoder.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A68809B.E12EF3D9@purplecoder.com>; from mark4@purplecoder.com on Fri, Jan 19, 2001 at 12:59:55 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Don't take this too seriously, the author had asked for flames without
meaning them, so this is the disclaimer ;-)]

On Fri, 19 Jan 2001, Mark I Manning IV wrote:

> found in teh kernel sources bz2.  It is done in parody of teh original
> doc and is meant to be laughed at as much as taken seriously.... no
> offense is intended towards the original author :)

>   int function(int x)   
>   {
>     body of function    // correctly braced and commented :)
>   }

So you claim // is a correct C comment? Poor guy :)

> Sane people all over the world have claimed that the K&R inconsistency
> is...  well...  inconsistent, and they are all right-thinking people
> who know that (a) K&R are _wrong_ and (b) K&R are very wrong.

Hum, K&R were "somewhat involved" in C, but C has in the meanwhile
become bigger than just K&R, so there.

> Linus states that the placement of the first brace at the end of the 
> first line keeps your code less vertical and thus saves you some space
> for comments.  This commenting style just plane sucks, 

Wow, airplanes. Who's bringing trains, ships and cars into Linux then?
(Not the other way round, that'd be easy.)

> I know, I was forced to use it once and I am defiantly brain 
> damaged :)

What a confession.

>     Chapter 5: Commenting
> 
> Comments are good, the more you comment your code the better. These
> comments are not for you, they are for the poor schmuck that has to 
> deal with your scratching later.  Never underestimate the stupidity
> of this guy, don't leave anything to chance.  Never assume that HE 
> will understand your logic simply because YOU do.

Write readable code ;-)

> I have never really liked the C language, it seems to me that it has a
> habit of making ANY idiot think he/she can be a coder.  C is an easy 
> language to learn but to be a good C coder takes years of hard study
> and a TRUE artistic flair for programming.  This means that 99% of all 
> C code is JUNK code.  

Not sure about the percentage, but there are langauages that are more
easily learned, and more easily abused, by people that have no clue what
locking or semaphores are good for that then write data base
applications for multiple simultaneous users.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
