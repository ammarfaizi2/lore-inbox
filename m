Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314083AbSEBAEE>; Wed, 1 May 2002 20:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314138AbSEBAED>; Wed, 1 May 2002 20:04:03 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8710 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314083AbSEBAEC>;
	Wed, 1 May 2002 20:04:02 -0400
Message-ID: <3CD0827B.1050902@mandrakesoft.com>
Date: Wed, 01 May 2002 20:04:11 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/00200203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] intel eths for 2.4 [was: Plan for e100-e1000 in mainline]
In-Reply-To: <20020501010828.GA1753@werewolf.able.es> <3CCF796C.5090401@mandrakesoft.com> <20020501234644.GA1698@werewolf.able.es>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon wrote:

>On 2002.05.01 Jeff Garzik wrote:
>
>>I expect Intel's Q/A to green light their current driver.  With a few 
>>patches it should be ready for 2.4.x soon.
>>

>I did it, taking drivers from 2.5.12, and at least it compiles.
>I have to try in the real box, but I don't think there were any problems,
>at least the same than 2.5....
>
>Marcelo, is there any chance to get this in next -pre or in .19 ?
>

When they are suitable for Marcelo, I'm going to send them to Marcelo.

As I wrote in the quoted message, they need some more patches, and I'm 
also interested in feedback from Intel Q/A (which is scheduled for 
sometime this week).

If you are interesting in maintaining 2.4.x patches for a short time, go 
for it.  But I would rather not have a almost-ready e100 go to Marcelo 
and get released in 2.4.19 in incomplete form.  It's out there, it's 
public, let's leave at that for a little while.

    Jeff




