Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262267AbVCJGTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262267AbVCJGTO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 01:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262443AbVCJGPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 01:15:42 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39082 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262376AbVCJGN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 01:13:27 -0500
Message-ID: <422FE571.7010101@pobox.com>
Date: Thu, 10 Mar 2005 01:13:05 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: "David S. Miller" <davem@davemloft.net>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       David Woodhouse <dwmw2@infradead.org>
Subject: Re: bk commits and dates
References: <1110422519.32556.159.camel@gaston>	 <20050309194744.6aef66b7.davem@davemloft.net> <1110433821.32524.176.camel@gaston>
In-Reply-To: <1110433821.32524.176.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> On Wed, 2005-03-09 at 19:47 -0800, David S. Miller wrote:
> 
>>On Thu, 10 Mar 2005 13:41:59 +1100
>>Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>>
>>
>>>I don't know if I'm the only one to have a problem with that, but it
>>>would be nice if it was possible, when you pull a bk tree, to have the
>>>commit messages for the csets in that tree be dated from the day you
>>>pulled, and not the day when they went in the source tree.
>>
>>When I'm working, I just do "bk csets" after I pull from Linus's
>>tree to review what went in since the last time I pulled.
> 
> 
> Yes, but the commit list archive is handy. I have quite good search
> capabilities in my mailer for example, and sometimes, when doign
> regression, it's quite useful to browse what went in between two
> releases with it (it's just more handy than bk csets).

Speaking strictly in terms of implementation, David Woodhouse's 
bk-commits mailer scripts could probably easily be tweaked to -not- set 
an explicit Date header on the outgoing emails.

It then becomes a matter of deciding whether this is a good idea or not :)

	Jeff



