Return-Path: <linux-kernel-owner+w=401wt.eu-S932397AbXAGFRx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbXAGFRx (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 00:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932400AbXAGFRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 00:17:53 -0500
Received: from terminus.zytor.com ([192.83.249.54]:39349 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932397AbXAGFRx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 00:17:53 -0500
Message-ID: <45A08269.4050504@zytor.com>
Date: Sat, 06 Jan 2007 21:17:29 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: nigel@nigel.suspend2.net
CC: "J.H." <warthog9@kernel.org>, Randy Dunlap <randy.dunlap@oracle.com>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>, webmaster@kernel.org
Subject: Re: [KORG] Re: kernel.org lies about latest -mm kernel
References: <20061214223718.GA3816@elf.ucw.cz>	 <20061216094421.416a271e.randy.dunlap@oracle.com>	 <20061216095702.3e6f1d1f.akpm@osdl.org>  <458434B0.4090506@oracle.com>	 <1166297434.26330.34.camel@localhost.localdomain>	 <1166304080.13548.8.camel@nigel.suspend2.net>  <459152B1.9040106@zytor.com> <1168140954.2153.1.camel@nigel.suspend2.net>
In-Reply-To: <1168140954.2153.1.camel@nigel.suspend2.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham wrote:
> Hi.
> 
> On Tue, 2006-12-26 at 08:49 -0800, H. Peter Anvin wrote:
>> Nigel Cunningham wrote:
>>> Hi.
>>>
>>> I've have git trees against a few versions besides Linus', and have just
>>> moved all but Linus' to staging to help until you can get your new
>>> hardware. If others were encouraged to do the same, it might help a lot?
>>>
>> Not really.  In fact, it would hardly help at all.
>>
>> The two things git users can do to help is:
>>
>> 1. Make sure your alternatives file is set up correctly;
>> 2. Keep your trees packed and pruned, to keep the file count down.
>>
>> If you do this, the load imposed by a single git tree is fairly negible.
> 
> Sorry for the slow reply, and the ignorance... what's an alternatives
> file? I've never heard of them before.
> 

Just a minor correction; it's the "alternates" file 
(objects/info/alternates).

	-hpa
