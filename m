Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030363AbWHQX1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030363AbWHQX1Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 19:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030364AbWHQX1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 19:27:23 -0400
Received: from ptb-relay03.plus.net ([212.159.14.214]:11715 "EHLO
	ptb-relay03.plus.net") by vger.kernel.org with ESMTP
	id S1030363AbWHQX1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 19:27:22 -0400
Message-ID: <44E4FB43.4090304@mauve.plus.com>
Date: Fri, 18 Aug 2006 00:26:59 +0100
From: Ian Stirling <ian.stirling@mauve.plus.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: James Courtier-Dutton <James@superbug.co.uk>
CC: Arjan van de Ven <arjan@infradead.org>,
       Anonymous User <anonymouslinuxuser@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: GPL Violation?
References: <40d80630608162248y498cb970r97a14c582fd663e1@mail.gmail.com> <1155795251.4494.9.camel@laptopd505.fenrus.org> <44E4C1B7.9020700@superbug.co.uk>
In-Reply-To: <44E4C1B7.9020700@superbug.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Courtier-Dutton wrote:
> Arjan van de Ven wrote:
>> On Wed, 2006-08-16 at 22:48 -0700, Anonymous User wrote:
>>> I work for a company that will be developing an embedded Linux based
>>> consumer electronic device.
>>>
>>> I believe that new kernel modules will be written to support I/O
>>> peripherals and perhaps other things.  I don't know the details right
>>> now.  What I am trying to do is get an idea of what requirements there
>>> are to make the source code available under the GPL.
>>
>> you should talk to a lawyer, not LKML.
>>
> 
> The easiest, no need to talk to a lawyer, most economical, way out of
> this is to simply make all source code open and published under the GPL
> or GPL compatible license with the appropriate "signed-off" entries.
> 
> As soon as you start trying to release some part of it as binary code,
> then lawyers have to be involved and that tends to cost a lot more.
> 
> People on this list are NOT lawyers, so don't ask about that option on
> this list.
> 
>>From the business perspective, it is likely to be far more profitable to
>  deliver an open source GPL licensed product to market, as you are then
> likely to get a lot of free development effort work done for you by your
> users.

Well...
The problem is that in many cases AIUI, a large entry barrier to
someone taking CPU A, chip B, sticking it in a box, and selling
it, is that there is no linux driver for chip B.
If you (as someone who does not make chip B) release the GPL'd
driver, then you're making it a fair bit easier for competitors,
who can now simply copy your often not very novel in any way
other than you thought of it first - design, and use that driver.
