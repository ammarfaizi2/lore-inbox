Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129285AbRBBFn3>; Fri, 2 Feb 2001 00:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129240AbRBBFnS>; Fri, 2 Feb 2001 00:43:18 -0500
Received: from blackdog.wirespeed.com ([208.170.106.25]:22532 "EHLO
	blackdog.wirespeed.com") by vger.kernel.org with ESMTP
	id <S129239AbRBBFnE>; Fri, 2 Feb 2001 00:43:04 -0500
Message-ID: <3A7A4992.5070303@redhat.com>
Date: Thu, 01 Feb 2001 23:45:54 -0600
From: Joe deBlaquiere <jadb@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22 i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To: Alex Belits <abelits@phobos.illtel.denver.co.us>
CC: linux-kernel@vger.kernel.org
Subject: Re: Serial device with very large buffer
In-Reply-To: <Pine.LNX.4.10.10102012111140.991-100000@mercury>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Alex Belits wrote:

> On Thu, 1 Feb 2001, Joe deBlaquiere wrote:
> 
> 
>> Hi Alex!
>> 
>> 	I'm a little confused here... why are we overrunning? This thing is 
>> running externally at 19200 at best, even if it does all come in as a 
>> packet.
> 
> 
>   Different Merlin -- original Merlin is 19200, "Merlin for Ricochet" is
> 128Kbps (or faster), and uses Metricom/Ricochet network.

so can you still limit the mru?

-- 
Joe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
