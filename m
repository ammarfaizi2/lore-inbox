Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285972AbRLTDdn>; Wed, 19 Dec 2001 22:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285974AbRLTDdd>; Wed, 19 Dec 2001 22:33:33 -0500
Received: from [206.40.202.198] ([206.40.202.198]:34576 "EHLO
	scsoftware.sc-software.com") by vger.kernel.org with ESMTP
	id <S285972AbRLTDdY>; Wed, 19 Dec 2001 22:33:24 -0500
Date: Wed, 19 Dec 2001 19:30:13 +0000 (   )
From: John Heil <kerndev@sc-software.com>
To: "David S. Miller" <davem@redhat.com>
cc: billh@tierra.ucsd.edu, bcrl@redhat.com, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: aio
In-Reply-To: <20011219.190629.03111291.davem@redhat.com>
Message-ID: <Pine.LNX.3.95.1011219190820.581I-100000@scsoftware.sc-software.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Dec 2001, David S. Miller wrote:

> Date: Wed, 19 Dec 2001 19:06:29 -0800 (PST)
> From: "David S. Miller" <davem@redhat.com>
> To: kerndev@sc-software.com
> Cc: billh@tierra.ucsd.edu, bcrl@redhat.com, torvalds@transmeta.com,
>     linux-kernel@vger.kernel.org, linux-aio@kvack.org
> Subject: Re: aio
> 
>    From: John Heil <kerndev@sc-software.com>
>    Date: Wed, 19 Dec 2001 18:57:34 +0000 (   )
>    
>    True for now, but if we want to expand linux into the enterprise and the
>    desktop to a greater degree, then we need to support the Java community to
>    draw them and their management in, rather than delaying beneficial 
>    features until their number on lkml reaches critical mass for a design
>    discussion.
> 
> Firstly, you say this as if server java applets do not function at all
> or with acceptable performance today.  That is not true for the vast
> majority of cases.
> 
> If java server applet performance in all cases is dependent upon AIO
> (it is not), that would be pretty sad.  But it wouldn't be the first
> time I've heard crap like that.  There is propaganda out there telling
> people that 64-bit address spaces are needed for good java
> performance.  Guess where that came from?  (hint: they invented java
> and are in the buisness of selling 64-bit RISC processors)
> 

Agree. However, put your business hat for a minute. We want increased
market share for linux and a lot of us, you included, live by it. 
If aio, the proposed implementation or some other, can provide an
adequate performance boost for Java (yet to be seen), that at least 
allows the marketing folks one more argument to draw users to linux. 
Do think the trade mags etc don't watch what we do? A demonstrable
advantage in Java performance is marketable and beneficial to all.
   

-
-----------------------------------------------------------------
John Heil
South Coast Software
Custom systems software for UNIX and IBM MVS mainframes
1-714-774-6952
johnhscs@sc-software.com
http://www.sc-software.com
-----------------------------------------------------------------

