Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263169AbUFFJSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263169AbUFFJSr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 05:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263173AbUFFJSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 05:18:47 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:39362 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id S263169AbUFFJSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 05:18:46 -0400
Message-ID: <40C2E157.7010507@t-online.de>
Date: Sun, 06 Jun 2004 11:18:15 +0200
From: "Harald Dunkel" <harald.dunkel@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040530
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6 & prism54: Computer gets stuck pretty often
References: <40C060C3.7020801@t-online.de> <200406052356.53200.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200406052356.53200.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: ECbCgGZFQevhpMw4p0sscLcUM+5Ecr7+pYZKIKn7it7u5cAbu+VXr4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> On Friday 04 June 2004 14:45, Harald Dunkel wrote:
> 
>>Hi folks,
>>
>>I am not sure how to reproduce this reliably, but using
>>the prism54 device my i386 machine gets stuck pretty often
>>(about 3 times a day). The mouse freezes, I cannot switch
>>to another vt, but Alt-SysRq-b works.
> 
> 
> Driver for prism54 is pretty young. Please visit prism54.org
> and fill in a bug report. Consider reading already existing bug
> reports too.
> 

It seems that there was a problem with the firmware. I
grabbed a new version from the manufacturer's ZIP file,
and the problem is gone.


Thanx anyway


Harri
