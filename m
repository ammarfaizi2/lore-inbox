Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269655AbRHCWrd>; Fri, 3 Aug 2001 18:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269653AbRHCWrY>; Fri, 3 Aug 2001 18:47:24 -0400
Received: from Huntington-Beach.Blue-Labs.org ([208.179.59.198]:63812 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S269658AbRHCWrN>; Fri, 3 Aug 2001 18:47:13 -0400
Message-ID: <3B6B29ED.2060808@blue-labs.org>
Date: Fri, 03 Aug 2001 18:47:09 -0400
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2+) Gecko/20010725
X-Accept-Language: en-us
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Ongoing 2.4 VM suckage
In-Reply-To: <Pine.LNX.4.33L.0108031751590.11893-100000@imladris.rielhome.conectiva>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd rather cut myself on the bleeding edge than have my extremities 
ripped off when my machine reaches critical mass :)

It's seriously frustrating to have important volatile work on your 
desktop and have to sit back and wait two hours for "skill -9 <some 
victim pid>" before you can use your machine again.

-d

Rik van Riel wrote:

>On Fri, 3 Aug 2001, David Ford wrote:
>
>>If it is that badly broken, isn't that sufficient criteria to justify
>>the patch?
>>
>
>It's not just a patch. Fixing this problem will require
>a major VM rewrite. A rewrite I really wasn't willing
>to make for 2.4.
>
>I'll start writing the thing, but I won't be aiming at
>getting it included in 2.4. I guess I could code it in
>such a way to give a drop-in replacement for people
>willing to cut themselves on the bleeding edge, though ;)
>


