Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311180AbSEINSA>; Thu, 9 May 2002 09:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311320AbSEINR7>; Thu, 9 May 2002 09:17:59 -0400
Received: from [195.63.194.11] ([195.63.194.11]:29970 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S311180AbSEINR5>; Thu, 9 May 2002 09:17:57 -0400
Message-ID: <3CDA6822.8080308@evision-ventures.com>
Date: Thu, 09 May 2002 14:14:26 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Bjorn Wesen <bjorn.wesen@axis.com>, Paul Mackerras <paulus@samba.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IDE 58
In-Reply-To: <Pine.LNX.4.10.10205081319400.30697-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Andre Hedrick napisa?:
> Alan, we talked about this and the driver/hardware has a flaw.
> If you count the total number of single IO operations to check
> status/error et al., it is out right fugly.  Preprocessing will kill us
> like today.

You mean the preprocessing in the devices firmware program of course?

Just to confirm I did get it right...

