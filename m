Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261914AbSKHN2q>; Fri, 8 Nov 2002 08:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261921AbSKHN2q>; Fri, 8 Nov 2002 08:28:46 -0500
Received: from chaos.analogic.com ([204.178.40.224]:7810 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S261914AbSKHN2p>; Fri, 8 Nov 2002 08:28:45 -0500
Date: Fri, 8 Nov 2002 08:36:58 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: ricklind@us.ibm.com
cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.46: duplicate statistics being gathered 
In-Reply-To: <200211081302.gA8D1io03168@eaglet.rain.com>
Message-ID: <Pine.LNX.3.95.1021108083018.12615A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Nov 2002, Rick Lindsley wrote:

>     The <unknown quantity of> applications out there which are reading
>     the disk info from /proc/stat need to be taught to go fishing in
>     /name-of-the-day-fs.
> 

There is /proc/version, which could have been used to make
`ps` and `top` compatable over, at least previously known
versions.

The last version of procps I have a copy of is 1.2. I don't see
anybody opening that file anywhere. Maybe it would be a good
idea to start.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
   Bush : The Fourth Reich of America


