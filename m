Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310601AbSCMN7O>; Wed, 13 Mar 2002 08:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310603AbSCMN7H>; Wed, 13 Mar 2002 08:59:07 -0500
Received: from [195.63.194.11] ([195.63.194.11]:59665 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S310601AbSCMN66>; Wed, 13 Mar 2002 08:58:58 -0500
Message-ID: <3C8F5AC3.6040904@evision-ventures.com>
Date: Wed, 13 Mar 2002 14:57:23 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org,
        reiserfs-list@namesys.com
Subject: Re: PROBLEM: Kernel Panic on 2.5.6 and 2.5.7-pre1 boot [PATCH] and discussion of Linux testing procedures
In-Reply-To: <Pine.LNX.4.44L.0203131048490.2181-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> On Wed, 13 Mar 2002, Hans Reiser wrote:
> 
> 
>>I would encourage requiring that every patch sent to Linus have two
>>signatures on it, one indicating that the author has tested it and
>>another indicating what second person has tested it.
>>
> 
> Agreed. Linus and Marcelo are very busy and shouldn't be
> bothered with untested patches.  If we only send them
> known-good stuff their lives should get a little bit
> easier.

You don't understand by accident that sometimes blind untested
changes serve the purpose of hinting at API changes in
areas where once doesn't have the slightest opportunity
of testing? Just simple count how many FS there are out there
and you should see that there is no chance for "quality"
testing before submission of advancements there.

Breakage is the price you have to pay for advancements.

(I'm not arguing over the particular case in quesiton here.
I'm just arguing over the proposal.)

