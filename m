Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261208AbVCESoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbVCESoI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 13:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbVCESm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 13:42:59 -0500
Received: from fire.osdl.org ([65.172.181.4]:35307 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261216AbVCESiM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 13:38:12 -0500
Message-ID: <4229F9D4.8030608@osdl.org>
Date: Sat, 05 Mar 2005 10:26:28 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adam Sampson <azz@us-lot.org>
CC: Greg KH <greg@kroah.com>, Chris Wright <chrisw@osdl.org>,
       torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFQ] Rules for accepting patches into the linux-releases tree
References: <20050304222146.GA1686@kroah.com> <y2azmxiifdj.fsf@cartman.at.fivegeeks.net>
In-Reply-To: <y2azmxiifdj.fsf@cartman.at.fivegeeks.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Sampson wrote:
> Greg KH <greg@kroah.com> writes:
> 
> 
>> - It must fix a problem that causes a build error (but not for things
>>   marked CONFIG_BROKEN), an oops, a hang, or a real security issue.
> 
> 
> So a trivial patch that fixed a data corruption issue wouldn't be
> accepted?
> 

That's called a critical patch.

-- 
~Randy
