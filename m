Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263541AbREYFnd>; Fri, 25 May 2001 01:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263543AbREYFnX>; Fri, 25 May 2001 01:43:23 -0400
Received: from server1.cosmoslink.net ([208.179.167.101]:33632 "EHLO
	server1.cosmoslink.net") by vger.kernel.org with ESMTP
	id <S263541AbREYFnM>; Fri, 25 May 2001 01:43:12 -0400
Message-ID: <001d01c0e4dd$8f9cd7e0$53a6b3d0@Toshiba>
From: "Jaswinder Singh" <jaswinder.singh@3disystems.com>
To: "Mike Galbraith" <mikeg@wen-online.de>,
        "Alan Cox" <laughing@shared-source.org>,
        <linux-kernel@vger.kernel.org>
Cc: "Jaswinder Singh" <jaswinder.singh@3disystems.com>
In-Reply-To: <Pine.LNX.4.33.0105250703550.568-100000@mikeg.weiden.de>
Subject: Re: Linux 2.4.4-ac17
Date: Thu, 24 May 2001 22:42:59 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Mike ,

>
> This one I tested with memleak.  It wasn't a leak, it was dcache
> growth.  Under vm stress, it shrank down fine.
>

It will depends upon lot of thing :-
1.What is your size of ramfs ,
2. Are you using any harddisk ,
3. How many many files are you creating ,
4. How frequently you are making files .
5. What are the size of your files ?

In my case , my ramfs is of 14 MB , using no hard-disk , i am continously
making and deleting files of 4 K size , my Machine hangs within 5 minutes ,
by saying no memory left.

Please tell me about your system and what you are doing on it ?

Thanks ,

Best Regards,

Jaswinder.
--
These are my opinions not 3Di.



> -Mike
>

