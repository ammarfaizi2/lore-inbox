Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261463AbVGWBBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbVGWBBZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 21:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262263AbVGWBBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 21:01:25 -0400
Received: from terminus.zytor.com ([209.128.68.124]:63955 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261463AbVGWBBX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 21:01:23 -0400
Message-ID: <42E19654.5030402@zytor.com>
Date: Fri, 22 Jul 2005 20:59:00 -0400
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Lang <david.lang@digitalinsight.com>
CC: Blaisorblade <blaisorblade@yahoo.it>, LKML <linux-kernel@vger.kernel.org>,
       Andrian Bunk <bunk@stusta.de>
Subject: Re: Giving developers clue how many testers verified certain kernel
 version
References: <200507230244.11338.blaisorblade@yahoo.it> <Pine.LNX.4.62.0507221749260.23492@qynat.qvtvafvgr.pbz>
In-Reply-To: <Pine.LNX.4.62.0507221749260.23492@qynat.qvtvafvgr.pbz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote:
> On Sat, 23 Jul 2005, Blaisorblade wrote:
> 
>> IMHO, I think that publishing statistics about kernel patches 
>> downloads would
>> be a very Good Thing(tm) to do. Peter, what's your opinion? I think 
>> that was
>> even talked about at Kernel Summit (or at least I thought of it 
>> there), but
>> I've not understood if this is going to happen.
> 
> 
> remember that most downloads will be from mirrors, and they don't get 
> stats from them.
> 
> David Lang
> 

That, plus there is http+ftp+rsync (not to mention git downloads, etc.) 
and the noise caused by other sites mirroring *us*.

	-hpa
