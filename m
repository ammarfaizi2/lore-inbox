Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132194AbRCYUkX>; Sun, 25 Mar 2001 15:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132196AbRCYUkE>; Sun, 25 Mar 2001 15:40:04 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:6916 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S132194AbRCYUj4>; Sun, 25 Mar 2001 15:39:56 -0500
Message-Id: <200103252039.f2PKdDs37909@aslan.scsiguy.com>
To: toddroy@softhome.net
cc: linux-kernel@vger.kernel.org
Subject: Re: new aic7xxx driver needs berkeley db? 
In-Reply-To: Your message of "Sun, 25 Mar 2001 13:09:50 EST."
             <3ABE346E.DDEBA85@softhome.net> 
Date: Sun, 25 Mar 2001 13:39:13 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi All,
>  I notice that the new aic7xxx driver in 2.4.3-pre7 needs some version
>of the berkeley db.  (the make file has -ldb1 in it).  It blew
>up on my because I apparently don't have it installed.  

Use the latest version of the driver from here:

http://people.FreeBSD.org/~gibbs/linux

It will only compile the fimware if you ask it.

Hopefully this will make it into the next pre kernel.

--
Justin
