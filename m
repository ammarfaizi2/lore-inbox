Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268294AbTGIOxc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 10:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268295AbTGIOxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 10:53:32 -0400
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:11459 "EHLO
	jaymale.blue-labs.org") by vger.kernel.org with ESMTP
	id S268294AbTGIOxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 10:53:30 -0400
Message-ID: <3F0C2FCB.8060304@blue-labs.org>
Date: Wed, 09 Jul 2003 11:07:55 -0400
From: David Ford <david+powerix@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030706
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ryan Underwood <nemesis-lists@icequake.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Forking shell bombs
References: <20030708202819.GM1030@dbz.icequake.net> <3F0B2CE6.8060805@nni.com> <20030708212517.GO1030@dbz.icequake.net>
In-Reply-To: <20030708212517.GO1030@dbz.icequake.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No such thing exists.  I can have 10,000 processes doing nothing and 
have a load average of 0.00.  I can have 100 processes each sucking cpu 
as fast as the electrons flow and have a dead box.

Learn how to manage resource limits and you can tuck another feather 
into your fledgeling sysadmin hat ;)

david

Ryan Underwood wrote:

>Hi,
>
>On Tue, Jul 08, 2003 at 04:43:18PM -0400, jhigdon wrote:
>  
>
>>Have you tried this on any 2.5.x kernels? Just curious to see what it 
>>does, I plan on giving it a go later.
>>    
>>
>
>I haven't, but a previous poster indicated that they had (2.5.74) with
>the same results.
>
>I wonder if we could find an upper limit on the number of allowable
>processes that would leave the box in a workable state?  Unfortunately,
>I don't have a spare box to test such things on at the moment. ;)
>
>Thanks,
>  
>

