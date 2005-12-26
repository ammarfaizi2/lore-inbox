Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbVLZUdu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbVLZUdu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 15:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932141AbVLZUdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 15:33:50 -0500
Received: from [85.8.13.51] ([85.8.13.51]:31159 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S932140AbVLZUdt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 15:33:49 -0500
Message-ID: <43B053A9.2020504@drzeus.cx>
Date: Mon, 26 Dec 2005 21:33:45 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mail/News 1.5 (X11/20051129)
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][MMC] Buggy cards need to leave programming state
References: <43AFEDF8.2060404@drzeus.cx> <20051226191307.GA17191@flint.arm.linux.org.uk> <43B04B43.5080705@drzeus.cx> <20051226201737.GB17191@flint.arm.linux.org.uk>
In-Reply-To: <20051226201737.GB17191@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Mon, Dec 26, 2005 at 08:57:55PM +0100, Pierre Ossman wrote:
>   
>> Russell King wrote:
>>     
>>> whereas it's impossible to tell with the November dump because
>>> the useful information has been edited out.  Hence the November
>>> dump is rather useless.
>>>       
>> What seems to be missing?
>>     
>
> The lines containing the respose to the CMD0x18 and CMD0x0d - iow
> the card status.  I'd like to see the result from the previous
> two commands to the errors occurring.
>
>   

I'll see if I can get hold of him to give a dump all the way from
loading the module.

Rgds
Pierre

