Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312486AbSDSOOc>; Fri, 19 Apr 2002 10:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312497AbSDSOOb>; Fri, 19 Apr 2002 10:14:31 -0400
Received: from chaos.analogic.com ([204.178.40.224]:4992 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S312486AbSDSOOa>; Fri, 19 Apr 2002 10:14:30 -0400
Date: Fri, 19 Apr 2002 10:14:41 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Dr. Death" <drd@homeworld.ath.cx>
cc: linux-kernel@vger.kernel.org
Subject: Re: A CD with errors (scratches etc.) blocks the whole system while reading damadged files
In-Reply-To: <3CBEC67F.3000909@filez>
Message-ID: <Pine.LNX.3.95.1020419100917.724A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Apr 2002, Dr. Death wrote:

> Problem:
> 
> I use SuSE Linux 7.2 and when I create md5sums from damaged files on a 
> CD, the WHOLE system  freezes or is ugly slow untill md5 has passed the 
> damaged part of the file !
> 

So what do you suggest? You can see from the logs that the device
is having difficulty  reading your damaged CD. You can do what
Windows-95 does (ignore the errors and pretend everything is fine),
or what Windows-98 and Windows-2000/Prof does (blue-screen, and re-boot),
or you can try like hell to read the files like Linux does. What do you
suggest?

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

