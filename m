Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030206AbWARJ2u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030206AbWARJ2u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 04:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030207AbWARJ2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 04:28:50 -0500
Received: from host-87-74-62-169.bulldogdsl.com ([87.74.62.169]:36969 "EHLO
	host-87-74-62-169.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1030206AbWARJ2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 04:28:49 -0500
Message-ID: <20060118092846.qa0cdzzhvod8g0oc@unsolicited.net>
Date: Wed, 18 Jan 2006 09:28:46 +0000
From: David R <david@unsolicited.net>
To: Greg KH <greg@kroah.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.16-rc1
References: <Pine.LNX.4.64.0601170001530.13339@g5.osdl.org>
	<43CD4504.8020705@unsolicited.net> <20060118045930.GC7292@kroah.com>
In-Reply-To: <20060118045930.GC7292@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) H3 (4.0.4)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Greg KH <greg@kroah.com>:

>> the (32bit) copy of VueScan that I use crawls along during preview like a
>> constipated tortoise. This is markedly similar to when 2.6.15 is under heavy
>> CPU load... high speed USB transfers slow to a crawl then too but everything
>> is fine at other times.
>>
>> dmesg etc looks ok. I'd appreciate it if anyone has any thoughts?
>
> Nothing has changed in usbfs that might cause this that I know of.  Can
> you use git to bisect what patch caused it?

Will do. May take a while though.

David.

