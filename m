Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262454AbVAUSJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262454AbVAUSJN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 13:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262447AbVAUSHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 13:07:23 -0500
Received: from fire.osdl.org ([65.172.181.4]:47836 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S262442AbVAUSDJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 13:03:09 -0500
Message-ID: <41F13FD7.1050502@osdl.org>
Date: Fri, 21 Jan 2005 09:45:59 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Simmons <jsimmons@pentafluge.infradead.org>
CC: Roman Zippel <zippel@linux-m68k.org>, Christoph Hellwig <hch@lst.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] remove console_macros.h
References: <20041231143457.GA9165@lst.de> <Pine.LNX.4.61.0501150439170.6118@scrub.home> <Pine.LNX.4.56.0501211753170.26614@pentafluge.infradead.org>
In-Reply-To: <Pine.LNX.4.56.0501211753170.26614@pentafluge.infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons wrote:
> Now its starting to look like the linuxconsole project :-)
> 
> On Sat, 15 Jan 2005, Roman Zippel wrote:
> 
> 
>>Hi,
>>
>>Remove the macros in console_macros.h and so make the structure references 
>>explicit.
>>
>>Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

James,
It is possible to delete large parts of large emails when replying.....

-- 
~Randy
