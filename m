Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbWIAP5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbWIAP5U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 11:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbWIAP5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 11:57:20 -0400
Received: from tzec.mtu.ru ([195.34.34.228]:26897 "EHLO tzec.mtu.ru")
	by vger.kernel.org with ESMTP id S932166AbWIAP5S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 11:57:18 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: RFC - sysctl or module parameters.
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Date: Fri, 01 Sep 2006 19:57:12 +0400
References: <17655.38092.888976.846697@cse.unsw.edu.au> <20060901101001.GA13912@kroah.com>
User-Agent: KNode/0.10.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20060901155715.A03285F9DAB@tzec.mtu.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

> On Fri, Sep 01, 2006 at 12:02:52PM +1000, Neil Brown wrote:
>> 
>>  - I could make it a module parameter: use_hostnames, and tell
>>    Jo to put
>>      options lockd use_hostnames=yes
>>    in /etc/modprobe.d/lockd  if that is what (s)he wants.
>>    But that won't work if the module is compiled in (will it?).
> 
> Yes it will.  See Documentation/kernel-parameters.txt for how it works.
> 

I must be blind today but I failed to find anything about this in mentioned
file. Nor do I see how it can possibly work. Could you please elaborate a
bit?

thank you

-andrey

