Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752197AbWAEUHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197AbWAEUHH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 15:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752199AbWAEUHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 15:07:07 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:29639 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752197AbWAEUHG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 15:07:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=BqPlaq3P48uEK1cLENKtrEg26EJMTbe4CnP4cbz885aLpNImItDLUO2pwI5ZA/XUAFKCU2CL+0gSGdu+Emae1dveXIYLfPr9vkq1UeeX71wx7RxsF7xpCBLL6xDPl/SmXlNMEvUdjMl4mXQRiB50EhE+ZVePYV1eY3LCc3g0puI=
Message-ID: <43BD7C5D.4090506@gmail.com>
Date: Thu, 05 Jan 2006 21:06:53 +0100
From: Patrizio Bassi <patrizio.bassi@gmail.com>
Reply-To: patrizio.bassi@gmail.com
Organization: patrizio.bassi@gmail.com
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051210)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Jaroslav Kysela <perex@suse.cz>, "Kernel," <linux-kernel@vger.kernel.org>
Subject: Re: [OT] ALSA userspace API complexity
References: <4uzow-1g5-13@gated-at.bofh.it> <5r0aY-2If-41@gated-at.bofh.it>	 <5r3Ca-88G-81@gated-at.bofh.it> <5reGV-6YD-23@gated-at.bofh.it>	 <5reGV-6YD-21@gated-at.bofh.it> <5rf9X-7yf-25@gated-at.bofh.it>	 <43BBB7DC.2060303@gmail.com> <1136487557.31583.37.camel@mindpipe>
In-Reply-To: <1136487557.31583.37.camel@mindpipe>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell ha scritto:

>On Wed, 2006-01-04 at 12:56 +0100, Patrizio Bassi wrote:
>  
>
>>that's a big problem. Needs a radical solution. Considering aoss works
>>in 50% of cases i suggest aoss improvement and not OSS keeping in
>>kernel.
>>
>>    
>>
>
>Please rephrase your statement in the form of a USEFUL BUG REPORT.
>
>Lee
>
>
>  
>
i opened an aoss/skype bug, that got closed without a complete fix..
because other problems were found...but actually that's not a complete
solution

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1224

