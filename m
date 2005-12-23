Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161032AbVLWUHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161032AbVLWUHK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 15:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161033AbVLWUHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 15:07:10 -0500
Received: from hermes.domdv.de ([193.102.202.1]:15108 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S1161032AbVLWUHI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 15:07:08 -0500
Message-ID: <43AC58EB.3080409@domdv.de>
Date: Fri, 23 Dec 2005 21:07:07 +0100
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051004)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl,
       Jens Axboe <axboe@suse.de>
Subject: Re: 2.6.15rc6: ide oops+panic
References: <43AB20DA.2020506@domdv.de> <20051223053621.6c437cee.akpm@osdl.org>
In-Reply-To: <20051223053621.6c437cee.akpm@osdl.org>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> Thanks.  Are you able to identify the most-recent kernel version which
> didn't do this?
> 

I'm trying currently Bartlomiej's workaround as I need some image
analysis results on this machine which will take a few days.

>From the back of my head:

2.6.13 seemed to run fine

2.6.14.2 which I tried just lately caused freezes which seem similar to
2.6.15rc6 (unfortunately without serial console, so no logs)

I can do further tests in a few days, if the workaround helps, otherwise
sooner.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
