Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030419AbVIONpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030419AbVIONpE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 09:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030420AbVIONpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 09:45:04 -0400
Received: from mail.tmr.com ([64.65.253.246]:63117 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S1030419AbVIONpC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 09:45:02 -0400
Message-ID: <43297F0C.4060404@tmr.com>
Date: Thu, 15 Sep 2005 10:02:52 -0400
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel mailing List <linux-kernel@vger.kernel.org>
Subject: Re: USB mass storage issue in 2.6.13
References: <432867BA.1000700@tmr.com> <20050914221537.GA10943@taniwha.stupidest.org>
In-Reply-To: <20050914221537.GA10943@taniwha.stupidest.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:

>On Wed, Sep 14, 2005 at 02:11:06PM -0400, Bill Davidsen wrote:
>
>  
>
>>Attached is a zip with the original dmesg and what somes out of
>>dmesg -s200000 now.
>>    
>>
>
>argh, why zip? it really blows for this sort of thing
>
>  
>
So does sending the whole huge file without compression. The advantage
of zip is that both relevant files can be put in one archive, and that
both archive and per-file comments can be added to make it clear what
each does. I could have done a compressed tar and an explanation, but
then you have to uncompress it to read the explanation.

I didn't pick that without thinking about it, and it seems at least as
useful as anything else which comes to mind, like multiple attachments.

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979


