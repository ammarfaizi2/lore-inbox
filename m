Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313731AbSDIEZK>; Tue, 9 Apr 2002 00:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313736AbSDIEZJ>; Tue, 9 Apr 2002 00:25:09 -0400
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:32721 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S313731AbSDIEZJ>;
	Tue, 9 Apr 2002 00:25:09 -0400
Message-ID: <3CB26D1F.50500@acm.org>
Date: Mon, 08 Apr 2002 23:25:03 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rob Radez <rob@osinvestor.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Further WatchDog Updates
In-Reply-To: <Pine.LNX.4.33.0204072342550.17511-100000@pita.lan>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Radez wrote:

>Ok, new version of watchdog updates is up at
>http://osinvestor.com/bigwatchdog-4.diff
>
Could the timeout be in milliseconds?  A lot of watchdogs have lower 
resolution, and I have written applications that require a lower 
resolution than a second.  Milliseconds is small enough to not cause 
problems, but big enough to give a good range of time.

-Corey

