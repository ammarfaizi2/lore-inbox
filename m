Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269425AbUI3TDB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269425AbUI3TDB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 15:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269415AbUI3TDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 15:03:01 -0400
Received: from mail.tmr.com ([216.238.38.203]:15111 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S269432AbUI3TCB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 15:02:01 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: Linux 2.6.9-rc3
Date: Thu, 30 Sep 2004 15:03:17 -0400
Organization: TMR Associates, Inc
Message-ID: <cjhkp7$6ef$1@gatekeeper.tmr.com>
References: <Pine.LNX.4.58.0409292036010.2976@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1096570471 6607 192.168.12.100 (30 Sep 2004 18:54:31 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
In-Reply-To: <Pine.LNX.4.58.0409292036010.2976@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Ok, this 2.6.9 cycle is getting too long, but here's a -rc3 and hopefully 
> we're getting there now.

A recent note related to read vs. write speed actually shows about a 40% 
degrade in write speed from 2.6.8. I hope 2.6.9 will be held back at 
least a few days in hopes of verifying or debunking that. I have some 
results showing "slower" by about 30%, but it was just production runs, 
not benchmarks.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
