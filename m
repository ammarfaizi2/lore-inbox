Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262042AbVDEVQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262042AbVDEVQV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 17:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262024AbVDEVNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 17:13:23 -0400
Received: from fire.osdl.org ([65.172.181.4]:7808 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262015AbVDEVIJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 17:08:09 -0400
Message-ID: <4252FC90.8060700@osdl.org>
Date: Tue, 05 Apr 2005 14:01:04 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: davidm@hpl.hp.com, linux-kernel@vger.kernel.org, stable@kernel.org,
       amy.griffis@hp.com, tony.luck@intel.com, linux-ia64@vger.kernel.org,
       dwmw2@infradead.org
Subject: Re: [03/08] fix ia64 syscall auditing
References: <20050405164539.GA17299@kroah.com>	 <20050405164647.GD17299@kroah.com>	 <16978.62622.80542.462568@napali.hpl.hp.com> <1112734158.468.0.camel@localhost.localdomain>
In-Reply-To: <1112734158.468.0.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Tue, 2005-04-05 at 13:27 -0700, David Mosberger wrote:
> 
>>>>>>>On Tue, 5 Apr 2005 09:46:48 -0700, Greg KH <gregkh@suse.de> said:
>>
>>  Greg> -stable review patch.  If anyone has any objections, please
>>  Greg> let us know.
>>
>>Nitpick: the patch introduces trailing whitespace.
> 
> 
> Sorry about that, I've removed it from the patch now.
> 
> 
>>Why doesn't everybody use emacs and enable show-trailing-whitespace? ;-)
> 
> 
> Because some of us use vim and ":set list" to see it, when we remember
> to... :)

others check received patches with a script instead of....
no, let's not debate $EDITOR.

-- 
~Randy
