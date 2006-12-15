Return-Path: <linux-kernel-owner+w=401wt.eu-S1752987AbWLORWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752987AbWLORWa (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 12:22:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752988AbWLORWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 12:22:30 -0500
Received: from mail.tmr.com ([64.65.253.246]:54218 "EHLO gaimboi.tmr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752987AbWLORW3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 12:22:29 -0500
Message-ID: <4582DB0D.5080905@tmr.com>
Date: Fri, 15 Dec 2006 12:27:41 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061105 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Will there be security updates for 2.6.17 kernels?
References: <elrop2$vdl$1@sea.gmane.org> <9a8748490612140710o478bf73p7efc607f545cf499@mail.gmail.com>
In-Reply-To: <9a8748490612140710o478bf73p7efc607f545cf499@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> On 14/12/06, Manuel Reimer <Manuel.Spam@nurfuerspam.de> wrote:
>> Hello,
>>
>> my problem is, that the slackware maintainers decided to use kernel
>> 2.6.17. Here is their comment, they posted to the changelog:
>>
> <snip>
>>
>> They had a 2.6.16 kernel in /extra before and as far as I know the
>> 2.6.16 kernel series still gets security updates.
>>
>> Is this also the case for 2.6.17 kernels?
> 
> No, that is not planned. 2.6.16.x is an exception.    -stable kernels
> (those with 2.6.x.y versions) are only released for the latest stable
> 2.6.x kernel. So currently that's 2.6.19 and as soon as 2.6.20 comes
> out there will not be any more 2.6.19.x, only 2.6.20.x   - I hope
> that's clear...
> 
A happy exception I would say, given that there have been several 
changes since then which might impact existing application software. 
There are reasons to stay with 2.6.16 until applications have been 
updated to handle the new unchanged behavior. See "VCD not readable" for 
details.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
