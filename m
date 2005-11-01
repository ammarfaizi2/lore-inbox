Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751086AbVKASMB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbVKASMB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 13:12:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbVKASMB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 13:12:01 -0500
Received: from www1.cdi.cz ([194.213.194.49]:59276 "EHLO www1.cdi.cz")
	by vger.kernel.org with ESMTP id S1751086AbVKASL7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 13:11:59 -0500
Message-ID: <4367AFE8.9080206@cdi.cz>
Date: Tue, 01 Nov 2005 19:11:52 +0100
From: Martin Devera <devik@cdi.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: "Moore, Eric Dean" <Eric.Moore@lsil.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Fusion-MPT slowness workaround
References: <91888D455306F94EBD4D168954A9457C04BE82D0@nacos172.co.lsil.com>
In-Reply-To: <91888D455306F94EBD4D168954A9457C04BE82D0@nacos172.co.lsil.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.9 (----)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Moore, Eric Dean wrote:
> On Tuesday, November 01, 2005 10:46 AM,  Martin Devera wrote:
> 
>>because I ran into problem with fusion mpt scsi with 2.6.14 yesterday
>>I tried to find a workaround.
>>Because it seems that there is bug in DV code I patched driver to skip
>>DV and use firmware negotiation data.
>>It "works for me" both compiled-in and as module.
>>
> 
> 
> NACK. Disabling DV is not the solution.
> 
> I have a fix I will post sometime this week.

excellent. Just to make it clear, I posted this one as quick workaround not
as final solution attempt.
Please consider CCing me when the patch will be available - I'll be pleased
to test it :-)

Martin
