Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262371AbUKDTX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262371AbUKDTX5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 14:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbUKDTUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 14:20:30 -0500
Received: from fire.osdl.org ([65.172.181.4]:5517 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S262371AbUKDTRS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 14:17:18 -0500
Message-ID: <418A7D96.40307@osdl.org>
Date: Thu, 04 Nov 2004 11:05:58 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: yiding_wang@agilent.com, linux-kernel@vger.kernel.org,
       Yidng_wang@agilent.com
Subject: Re: QM_MODULES not implemented in 2.6.9
References: <08A354A3A9CCA24F9EE9BE13600CFBC50F3AE3@wcosmb07.cos.agilent.com> <1099595121.16640.21.camel@laptop.fenrus.org>
In-Reply-To: <1099595121.16640.21.camel@laptop.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Thu, 2004-11-04 at 10:57 -0800, yiding_wang@agilent.com wrote:
> 
>>I noticed that this issue was there before but thought it was being taken care of since my Linux-2.6.2 kernel did not complain. Now I loaded Linux-2.6.9 and this QM_MODULES Function not implemented error pops up whenever I run module related command.
>>
>>If I need update module patch, could someone tell which module patch I should apply? If something else is wrong, please advice. The kernel is configured to support module.
> 
> 
> you need to use a 2.6 compatible modutils....

one of your email addresses also bounces.

-- 
~Randy
