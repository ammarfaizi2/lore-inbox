Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271033AbTGPTTJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 15:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271059AbTGPTTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 15:19:09 -0400
Received: from freeside.toyota.com ([63.87.74.7]:12777 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP id S271033AbTGPTTG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 15:19:06 -0400
Message-ID: <3F15A8A5.4020603@tmsusa.com>
Date: Wed, 16 Jul 2003 12:33:57 -0700
From: jjs <jjs@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: woes with 2.6.0-test1 and xscreensaver/xlock
References: <20030716172758.GA1792@hobbes.itsari.int> <Pine.LNX.4.53.0307161454180.32541@montezuma.mastecende.com> <20030716121627.0ac0d238.rddunlap@osdl.org> <Pine.LNX.4.53.0307161512060.32541@montezuma.mastecende.com>
In-Reply-To: <Pine.LNX.4.53.0307161512060.32541@montezuma.mastecende.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:

>On Wed, 16 Jul 2003, Randy.Dunlap wrote:
>
>  
>
>>It happens to me all the time (so I stopped using xscreensaver).
>>
>>Alan says that it's fixed in RH 9 IIRC, but no details about the
>>problem or the fix.... ?  Sounds a little like a userspace (library
>>or syscall) issue.  Someone mentioned PAM also.
>>    
>>
>
>Aha! The machine i tested it on was RH9, i'll have to try this on 7.3 (w/o 
>updates) but yes, it sounds like a userspace problem.
>  
>
Yes, RH 9 ships with a version of xscreensaver (and whatever 
infrastructure) which works with both 2.4 and 2.5/2.6 kernels.

I reported the same xscreensaver problem on 2.5 kernels, but found that 
it was automagically solved when I installed RH 9 -

Hope this helps,

Joe

