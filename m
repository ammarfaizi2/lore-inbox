Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261537AbVBWTLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbVBWTLT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 14:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbVBWTLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 14:11:19 -0500
Received: from mail.tmr.com ([216.238.38.203]:45060 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S261537AbVBWTLP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 14:11:15 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: [BK] upgrade will be needed
Date: Wed, 23 Feb 2005 14:15:59 -0500
Organization: TMR Associates, Inc
Message-ID: <421CD66F.90601@tmr.com>
References: <4075.10.10.10.24.1108751663.squirrel@linux1><seanlkml@sympatico.ca> <20050218214555.1f71c2e4.aradorlinux@yahoo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
X-Trace: gatekeeper.tmr.com 1109185196 8215 192.168.12.100 (23 Feb 2005 18:59:56 GMT)
X-Complaints-To: abuse@tmr.com
Cc: Sean <seanlkml@sympatico.ca>, tytso@mit.edu, vonbrand@inf.utfsm.cl,
       cfriesen@nortel.com, cs@tequila.co.jp, galibert@pobox.com,
       kernel@crazytrain.com, linux-kernel@vger.kernel.org
To: "d.c" <aradorlinux@yahoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
In-Reply-To: <20050218214555.1f71c2e4.aradorlinux@yahoo.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

d.c wrote:
> El Fri, 18 Feb 2005 13:34:23 -0500 (EST),
> "Sean" <seanlkml@sympatico.ca> escribió:
> 
> 
> 
>>BK already feeds patches out at the head, surely if it's as powerful as
>>you think, it could feed a free SCM too for your non-bk friends in the
>>community.
> 
> 
> Who cares, really?
> 
> 1) Linux was never supposed to have a "head", but -pre/-rc diff patches
> 
> 2) And more important, *nobody* works against "linus' bk head". Everyone who
>     is implementing something so intrusive that needs to keep track of the
>     "development head" developes again the _true_ "head" of the linux
>     kernel - akpm's tree.

If I wanted to develop something which would eventually go into 
mainline, I certainly would do it against Linus' tree. There are many 
things going on in -mm which might or might not require significant 
changes in approach to work. I think -mm is a great place to try the 
scheduler of the week, but unless some feature requires one of those, 
it's easier to start from a known base.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
