Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030464AbVIIUda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030464AbVIIUda (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 16:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030466AbVIIUda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 16:33:30 -0400
Received: from smtp.dkm.cz ([62.24.64.34]:60684 "HELO smtp.dkm.cz")
	by vger.kernel.org with SMTP id S1030464AbVIIUd3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 16:33:29 -0400
Message-ID: <4321F19A.3020503@rulez.cz>
Date: Fri, 09 Sep 2005 22:33:30 +0200
From: iSteve <isteve@rulez.cz>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: 7eggert@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: query_modules syscall gone? Any replacement?
References: <4KSFY-2pO-17@gated-at.bofh.it> <E1EDpQq-0000iV-Oe@be1.lrz>
In-Reply-To: <E1EDpQq-0000iV-Oe@be1.lrz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm aware of the sysfs interface -- but neither /proc/modules nor 
/sys/module/ actually really supplement the query_module api...

  - iSteve

Bodo Eggert wrote:
> iSteve <isteve@rulez.cz> wrote:
> 
> 
>>  May I then ask, why is the query_module syscall gone? And more
>>importantly, what replaces it, if anything?
> 
> 
> I don't know query_module, but ls -laR /sys/module might do the job.
