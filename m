Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265796AbTIJVhj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 17:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265800AbTIJVhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 17:37:39 -0400
Received: from fep04-svc.mail.telepac.pt ([194.65.5.203]:64445 "EHLO
	fep04-svc.mail.telepac.pt") by vger.kernel.org with ESMTP
	id S265796AbTIJVhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 17:37:34 -0400
Message-ID: <3F5F99AD.6080502@vgertech.com>
Date: Wed, 10 Sep 2003 22:37:49 +0100
From: Nuno Silva <nuno.silva@vgertech.com>
Organization: VGER, LDA
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: en-us, pt
MIME-Version: 1.0
To: Aaron Lehmann <aaronl@vitelus.com>
CC: Misha Nasledov <misha@nasledov.com>, linux-kernel@vger.kernel.org
Subject: Re: bttv bug
References: <20030910064158.GA19930@nasledov.com> <20030910074123.GH18280@vitelus.com>
In-Reply-To: <20030910074123.GH18280@vitelus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Aaron Lehmann wrote:
> Can you reproduce it without the nvidia module and produce a call
> trace that doesn't include nvidia symbols?

Yes, and then try bttv patches from http://bytesex.org/bttv/

2.6.0's bttv driver is misbehaving in my setup for ages... Try bytesex's 
patches and report back, please.

Regards,
Nuno Silva

> 
> On Tue, Sep 09, 2003 at 11:41:58PM -0700, Misha Nasledov wrote:
> 
>>Hi,
>>
>>After upgrading to -test5, my bt878 card ceased to function properly. My
>>kernel is tainted with the nvidia kernel module but I know for a fact that 
>>bttv worked just fine not too long ago and I have not upgraded my nvidia
>>drivers since.
>>
>>I have the following message in my dmesg:



