Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261227AbVBQXCz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbVBQXCz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 18:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbVBQW7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 17:59:54 -0500
Received: from mail.tmr.com ([216.238.38.203]:60165 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S261223AbVBQW7b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 17:59:31 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: ide-scsi is deprecated for cd burning! Use ide-cd and   give
 dev=/dev/hdX as device
Date: Thu, 17 Feb 2005 18:03:58 -0500
Organization: TMR Associates, Inc
Message-ID: <cv36vj$54m$3@gatekeeper.tmr.com>
References: <1108499791.11356.9.camel@bastov><1108426832.5015.4.camel@bastov> <1108607227.9720.11.camel@bastov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1108680500 5270 192.168.12.100 (17 Feb 2005 22:48:20 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
In-Reply-To: <1108607227.9720.11.camel@bastov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergio Monteiro Basto wrote:
> with hdc=scsi haldeamon doesn't recognize cdwriter.
> but with hdc=ide-scsi (was the original from kernel 2.4) haldaamon
> reconize my cdwriter !
> 
> So this message of this subject just make me wast my time and lose my
> patience. ( because I forgot to enable haldaemon before to try
> understand the message ) 
> Still don't understand if I should or not change to ide-cd on my FC3, if
> not please remove the message, if yes rewrite it please .

Since ide-scsi seems needed to do firmware upgrades and multi-session 
CDs as user, like Mark Twain I believe the reports of death are greatly 
exaggerated.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
