Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266648AbUI1Bm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266648AbUI1Bm5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 21:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267451AbUI1Bm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 21:42:57 -0400
Received: from out006pub.verizon.net ([206.46.170.106]:32207 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP id S266648AbUI1Bmg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 21:42:36 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm4
Date: Mon, 27 Sep 2004 21:42:35 -0400
User-Agent: KMail/1.7
Cc: Ingo Molnar <mingo@elte.hu>, Matt Heler <lkml@lpbproductions.com>
References: <20040926181021.2e1b3fe4.akpm@osdl.org> <200409270940.39851.lkml@lpbproductions.com> <20040927201709.GA19257@elte.hu>
In-Reply-To: <20040927201709.GA19257@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409272142.35182.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [141.153.74.116] at Mon, 27 Sep 2004 20:42:35 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 September 2004 16:17, Ingo Molnar wrote:
>* Matt Heler <lkml@lpbproductions.com> wrote:
>> Yup, turning opff pre-emptable bkl makes it boot up and work just
>> fine.
>
>do you know which particular subsystem broke (by comparing the
> failed and the successful bootlogs)?

How do we save the broken bootlog when the machines only response is 
to the reset key?

> Could you boot with 'debug' on 
> the boot command line - do you get more messages around the hang
> that could pinpoint the breakage?
>
> Ingo

I could rebuild it and try, but the best capture is gonna be my 
digital camera off the screen, whose output is about 750KB per frame.  
Tommorrow maybe, I spent the afternoon warming a seat in the Dr's 
reception room.


-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.26% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
