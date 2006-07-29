Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbWG2WFO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbWG2WFO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 18:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbWG2WFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 18:05:14 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:10647
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1750830AbWG2WFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 18:05:12 -0400
Message-ID: <44CBDB8D.3030209@microgate.com>
Date: Sat, 29 Jul 2006 17:05:01 -0500
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.18-rc2-mm1 timer int 0 doesn't work
References: <20060727015639.9c89db57.akpm@osdl.org>	<1154112276.3530.3.camel@amdx2.microgate.com>	<20060728144854.44c4f557.akpm@osdl.org>	<20060728233851.GA35643@muc.de>	<1154187239.3404.2.camel@amdx2.microgate.com> <m1lkqc9omh.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1lkqc9omh.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
>>I tried to patch it up and got it to compile without
>>errors or warnings. The result was a hard freeze early in
>>the boot, so I suspect more is necessary to restore that
>>function.
> 
> 
> Any chance you can post the your reversed version of remove-timer-fallback
> so we can have a clue about what happened.

While I'm taking the time to post my attempt at a reveresed patch,
it would also be useful for the person who originated the
patch to do the same. I'm not an expert on the code in
question, so the participation of the original author
would help speed things along.

--
Paul
