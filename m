Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262731AbVAKAxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262731AbVAKAxV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 19:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262617AbVAJVc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 16:32:57 -0500
Received: from mail.tmr.com ([216.238.38.203]:32274 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S262602AbVAJVQz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 16:16:55 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Whatever happened to the real mode driver idea?
Date: Mon, 10 Jan 2005 16:19:31 -0500
Organization: TMR Associates, Inc
Message-ID: <cruqp5$c59$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1105391205 12457 192.168.12.100 (10 Jan 2005 21:06:45 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There has been some discussion of some "universal real mode" driver to 
allow hardware without an open source driver to operate with Linux. It's 
been about a year since this came up, and as I recall the last 
discussion ended with people opposed to using that as a reverse 
engineering tool, due to possible legal issues.

But I have a technical question, wouldn't a real mode use of BIOS code 
be more secure that the current situation of tainted drivers running in 
the kernel? Please take political discussion elsewhere, I'm curious 
about the safty issue, not the legal or advocacy issues.

Being an old MULTICS guy, my first though when protection rings came out 
was that the drivers should be out of ring zero.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
