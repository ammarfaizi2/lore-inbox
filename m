Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422689AbWI2T6v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422689AbWI2T6v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 15:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422690AbWI2T6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 15:58:51 -0400
Received: from rtr.ca ([64.26.128.89]:54032 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1422689AbWI2T6u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 15:58:50 -0400
Message-ID: <451D7AF7.50001@rtr.ca>
Date: Fri, 29 Sep 2006 15:58:47 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Arrr! Linux 2.6.18
References: <Pine.LNX.4.64.0609192126070.4388@g5.osdl.org>	<451CDBE3.2080707@rtr.ca> <20060929014433.bc01e83c.akpm@osdl.org> <451D5D66.8030501@rtr.ca>
In-Reply-To: <451D5D66.8030501@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
>> Mark Lord <lkml@rtr.ca> wrote:
..
>>> Mmm.. I wonder if this could be what killed resume-from-RAM
>>> on my notebook, between -rc6 and -final ?
..
> I'll look through all of the post-rc6 changes and see if anything
> else might be a candidate.

Thus far, 2.6.18-rc7 seems to be okay, though it will take a day
or so to win full confidence here.  So now to pick over the rc7-final
patches..

Cheers
