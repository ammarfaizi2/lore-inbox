Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262430AbVAZQyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262430AbVAZQyp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 11:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262351AbVAZQxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 11:53:19 -0500
Received: from fire.osdl.org ([65.172.181.4]:42678 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S262417AbVAZQu4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 11:50:56 -0500
Message-ID: <41F7BB01.3050200@osdl.org>
Date: Wed, 26 Jan 2005 07:45:05 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Waitz <tali@admingilde.org>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation updates
References: <20050126105621.GW3069@admingilde.org>
In-Reply-To: <20050126105621.GW3069@admingilde.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Waitz wrote:
> hoi :)
> 
> I have created some updates to the Linux documentation.
> 
> This includes two important fixes that allow to generate DocBook
> documenation from kernel-doc comments again and some low-priority
> updates to the kernel-doc comments itself.
> 
> All patches are available in my BK repository, it only contains
> documentation updates, no code changes.
> (The fixes have been reported here before but have not been merged yet.)
> 
> Please do a
> 
> 	bk pull bk://tali.bkbits.net/linux-doc
> 
> This will update the following files:

I'll be glad to review them if you email them or put them on
some web page....

-- 
~Randy
