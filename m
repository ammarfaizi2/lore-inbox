Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbUACOSb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 09:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263452AbUACOSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 09:18:31 -0500
Received: from host-64-65-253-246.alb.choiceone.net ([64.65.253.246]:16019
	"EHLO gaimboi.tmr.com") by vger.kernel.org with ESMTP
	id S263448AbUACOS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 09:18:29 -0500
Message-ID: <3FF6CF34.80104@tmr.com>
Date: Sat, 03 Jan 2004 09:18:28 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: wrlk@riede.org
CC: linux-kernel@vger.kernel.org
Subject: Re: The survival of ide-scsi in 2.6.x
References: <20031226181242.GE1277@linnie.riede.org>
In-Reply-To: <20031226181242.GE1277@linnie.riede.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willem Riede wrote:
> I know that many feel that ide-scsi is useless, and should go away.
> And you are probably tired of message threads talking about it.
> Yet I ask respectfully that you hear me out, and give me feedback.
> 
> I need ide-scsi to survive. Why? I maintain osst, a driver for
> OnStream tape drives, which need special handling. These drives
> exist in SCSI, ATAPI, USB and IEEE1394 versions.


> In the spirit of cleaning up one's own mess, I am working on a new
> patch, to hopefully alleviate the problems. I've made liberal use 
> of the attachments to the osdl bug reports [1]-[4] created by 
> Mike Christie and a patch from Philip Auld [10], to give credit
> where it is due. I've also looked at ide-cd to see what it does 
> differently.


> Linus states in [7] that ide-scsi needs a maintainer. I haven't seen 
> anyone step forward, so that leads me to believe I may be the only 
> person that depends enough on ide-scsi to be motivated?
> 
> If people will have me, I am prepared to take on that responsibility.
> I am just concerned that I may not have enough of a variety of devices
> to be able to thoroughly test it (unless the DI-30 is the only one :-)).
> What do people see as the requirements to be able to maintain ide-scsi?

Sounds good to me, here we have someone who has both the need, the 
ambition, and the time to do this. Users of tape and MO still have need 
for ide-scsi, and would be happy to help test at least.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
