Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263572AbTJ0UnS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 15:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263573AbTJ0UnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 15:43:18 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:63462 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S263572AbTJ0UnO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 15:43:14 -0500
Message-ID: <3F9D84BA.7070904@pacbell.net>
Date: Mon, 27 Oct 2003 12:48:58 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Patrick Mochel <mochel@osdl.org>
CC: ian.soboroff@nist.gov, linux-kernel@vger.kernel.org,
       Johannes Erdfelt <johannes@erdfelt.com>
Subject: Re: APM suspend still broken in -test9
References: <Pine.LNX.4.44.0310271219040.13116-100000@cherise>
In-Reply-To: <Pine.LNX.4.44.0310271219040.13116-100000@cherise>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel wrote:
> On Mon, 27 Oct 2003, David Brownell wrote:
> 
> 
>>Those are the same symptoms I saw in test7, fixed by:
>>
>>   http://marc.theaimsgroup.com/?l=linux-kernel&m=106606272103414&w=2
>>
>>Patrick, were you going to submit your patch to resolve this?
>>I'm thinking this kind of problem would meet Linus's test10
>>integration criteria.
> 
> 
> I should be merging early this week. Sorry about the delay, but it will 
> get in soon.

Good -- I just wanted to make sure it didn't get lost, more
folk are noticing it lately.


> BTW, can you help with any of the uhci-hcd suspend/resume issues? I do not 
> know the code well enough to track it down.. 

I'm trying to avoid that; sorry!  Some of them could be related to UHCI
patches that are waiting for feedback/approval from Johannes.

- Dave





