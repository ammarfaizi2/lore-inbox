Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129197AbRBBEm6>; Thu, 1 Feb 2001 23:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129838AbRBBEms>; Thu, 1 Feb 2001 23:42:48 -0500
Received: from blackdog.wirespeed.com ([208.170.106.25]:9988 "EHLO
	blackdog.wirespeed.com") by vger.kernel.org with ESMTP
	id <S129197AbRBBEma>; Thu, 1 Feb 2001 23:42:30 -0500
Message-ID: <3A7A34EA.7060503@redhat.com>
Date: Thu, 01 Feb 2001 22:17:46 -0600
From: Joe deBlaquiere <jadb@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22 i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [linux-audio-dev] low-latency scheduling patch for 2.4.0
In-Reply-To: <Pine.LNX.4.30.0102012202040.1102-100000@imladris.demon.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



David Woodhouse wrote:

> On Thu, 1 Feb 2001, Pavel Machek wrote:
> 
> 
>> I thought that Vtech Helio folks already have XIP supported...
> 
> 
> Plenty of people are doing XIP of the kernel. I'm not aware of anyone 
> doing XIP of userspace pages. 

uClinux does XIP (readonly) for userspace programs in the Dragonball 
port. Of course it's a different executable format than Linux, so there 
are some hooks for it.

-- 
Joe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
