Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271318AbRICRnG>; Mon, 3 Sep 2001 13:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270821AbRICRm4>; Mon, 3 Sep 2001 13:42:56 -0400
Received: from [216.151.155.121] ([216.151.155.121]:61190 "EHLO
	belphigor.mcnaught.org") by vger.kernel.org with ESMTP
	id <S271318AbRICRmq>; Mon, 3 Sep 2001 13:42:46 -0400
To: psusi@cfl.rr.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [bug report] NFS and uninterruptable wait states
In-Reply-To: <01090310483100.26387@faldara>
	<m3zo8cp93a.fsf@belphigor.mcnaught.org> <01090311553201.26387@faldara>
From: Doug McNaught <doug@wireboard.com>
Date: 03 Sep 2001 13:42:59 -0400
In-Reply-To: Phillip Susi's message of "Mon, 3 Sep 2001 11:55:32 +0000"
Message-ID: <m3sne4p3vg.fsf@belphigor.mcnaught.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) XEmacs/21.1 (20 Minutes to Nikko)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Susi <psusi@cfl.rr.com> writes:

> That's all well and good that the process won't get an error back, but imho, 
> a process should *NEVER* be beyond the reach of a SIGKILL.  I mean, an 
> unkillable process prevents a clean shutdown, doesn't it?  ( can't kill the 
> process, can't unmount the filesystem ).  

D state has always meant unkillable.  If you don't like it, you now
know how to change it.

-Doug
-- 
Free Dmitry Sklyarov! 
http://www.freesklyarov.org/ 

We will return to our regularly scheduled signature shortly.
