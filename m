Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261295AbULAQOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbULAQOo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 11:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbULAQOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 11:14:44 -0500
Received: from 221-169-69-23.adsl.static.seed.net.tw ([221.169.69.23]:58275
	"EHLO cola.voip.idv.tw") by vger.kernel.org with ESMTP
	id S261295AbULAQOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 11:14:35 -0500
Message-ID: <41ADED7B.1060607@cola.voip.idv.tw>
Date: Thu, 02 Dec 2004 00:12:43 +0800
From: Wen-chien Jesse Sung <jesse@cola.voip.idv.tw>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-17
References: <41AD9A33.3070205@cola.voip.idv.tw> <20041201113746.GA21640@elte.hu> <20041201115221.GA22697@elte.hu> <41ADBE1C.9010807@cola.voip.idv.tw> <20041201132710.GA8328@elte.hu>
In-Reply-To: <20041201132710.GA8328@elte.hu>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
>>I redo the test with a vanilla 2.6.10-rc2-mm3-V0.7.31-16 again, and it
>>still hangs at hwclock. Here's the complete config file.
> ok, could you try the -17 kernel i've just uploaded to the usual place:
> 
>     http://redhat.com/~mingo/realtime-preempt/
> 
> does this fix the lockup?

Yes, hwclock works fine with -17. Thanks!  :)

-- 
Best Regards,
Wen-chien Jesse Sung
