Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263652AbTCUXon>; Fri, 21 Mar 2003 18:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264311AbTCUXon>; Fri, 21 Mar 2003 18:44:43 -0500
Received: from kestrel.vispa.uk.net ([62.24.228.12]:19474 "EHLO
	kestrel.vispa.uk.net") by vger.kernel.org with ESMTP
	id <S263652AbTCUXom>; Fri, 21 Mar 2003 18:44:42 -0500
Message-ID: <3E7BA618.3060603@walrond.org>
Date: Fri, 21 Mar 2003 23:54:00 +0000
From: Andrew Walrond <andrew@walrond.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Kevin P. Fleming" <kpfleming@cox.net>
CC: Greg KH <greg@kroah.com>, "Adam J. Richter" <adam@yggdrasil.com>,
       linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: Re: small devfs patch for 2.5.65, plan to replace /sbin/hotplug
References: <20030321014048.A19537@baldur.yggdrasil.com> <3E7B79D5.3060903@cox.net> <20030321232131.GA18010@kroah.com> <3E7BA329.2060806@cox.net>
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sounds wonderful. Any downsides?

Andrew Walrond

Kevin P. Fleming wrote:
> Greg KH wrote:
> 
>>> Are you still considering smalldevfs for 2.6 inclusion? If not, then 
>>> I'd like to discuss with you (and Greg KH) the possibility of just 
>>> eliminating devfs entirely, and moving to a userspace version that is 
>>> driven entirely by /sbin/hotplug.
>>
>>
>>
>> You mean with something like this:
>>     http://www.linuxsymposium.org/2003/view_abstract.php?talk=94
>> :)
>>
> 
> Yep, that's the one. Sounds very simple and straightforward to me. The 
> most complex part will be defining some file structure to define the 
> user's desired naming policy to the agent that handles the hotplug events.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


