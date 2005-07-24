Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261433AbVGXSpV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbVGXSpV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 14:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbVGXSpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 14:45:21 -0400
Received: from r3az252.chello.upc.cz ([213.220.243.252]:59545 "EHLO
	aquarius.doma") by vger.kernel.org with ESMTP id S261433AbVGXSpS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 14:45:18 -0400
Message-ID: <42E3E1BC.2050509@ribosome.natur.cuni.cz>
Date: Sun, 24 Jul 2005 20:45:16 +0200
From: =?windows-1252?Q?Martin_MOKREJ=8A?= 
	<mmokrejs@ribosome.natur.cuni.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Giving developers clue how many testers verified certain kernel
 version
References: <42E04D11.20005@ribosome.natur.cuni.cz> <20050722231126.GB3160@stusta.de>
In-Reply-To: <20050722231126.GB3160@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,
  well, the idea was to give you a clue how many people did NOT complain
because it either worked or they did not realize/care. The goal
was different. For example, I have 2 computers and both need current acpi
patch to work fine. I went to bugzilla and found nobody has filed such bugs
before - so I did and said it is already fixed in current acpi patch.
But you'd never know that I tested that successfully. And I don't believe
to get emails from lkml that I installed a patch and it did not break
anything. I hope you get the idea now. ;)
Martin

Adrian Bunk wrote:
> On Fri, Jul 22, 2005 at 03:34:09AM +0200, Martin MOKREJ? wrote:
> 
> 
>>Hi,
> 
> 
> Hi Martin,
> 
> 
>> I think the discussion going on here in another thread about lack
>>of positive information on how many testers successfully tested certain
>>kernel version can be easily solved with real solution.
>>
>> How about opening separate "project" in bugzilla.kernel.org named
>>kernel-testers or whatever, where whenever cvs/svn/bk gatekeepers
>>would release some kernel patch, would open an empty "bugreport"
>>for that version, say for 2.6.13-rc3-git4.
>>
>> Anybody willing to join the crew who cared to download the patch
>>and tested the kernel would post just a single comment/follow-up
>>to _that_ "bugreport" with either "positive" rating or URL
>>of his own bugreport with some new bug. When the bug get's closed
>>it would be immediately obvious in the 2.6.13-rc3-git4 bug ticket
>>as that bug will be striked-through as closed.
>>
>> Then, we could easily just browse through and see that 2.6.13-rc2
>>was tested by 33 fellows while 3 of them found a problem and 2 such
>>problems were closed since then.
>>...
> 
> 
> most likely, only a small minory of the people downloading a patch would 
> register at such a "project".
> 
> The important part of the work, the bug reports, can already today go to 
> lnux-kernel and/or the Bugzilla.
> 
> You'd spend efforts for such a "project" that would only produce some 
> numbers of questionable value.
> 
> 
>>Martin
> 
> 
> cu
> Adrian
> 

-- 
Martin Mokrejs
Email: 'bW9rcmVqc21Acmlib3NvbWUubmF0dXIuY3VuaS5jeg==\n'.decode('base64')
GPG key is at http://www.natur.cuni.cz/~mmokrejs
