Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbTKMHya (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 02:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbTKMHya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 02:54:30 -0500
Received: from as13-5-5.has.s.bonet.se ([217.215.179.23]:15000 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S262115AbTKMHy2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 02:54:28 -0500
Message-ID: <3FB3392B.1050801@stesmi.com>
Date: Thu, 13 Nov 2003 08:56:27 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jh@oobleck.astro.cornell.edu
CC: solt@dns.toxicfilms.tv, linux-kernel@vger.kernel.org
Subject: Re: Via KT600 support?
References: <200311111921.hABJLur16428@oobleck.astro.cornell.edu> <Pine.LNX.4.51.0311121016130.30003@dns.toxicfilms.tv> <200311121509.hACF9HG20967@oobleck.astro.cornell.edu>
In-Reply-To: <200311121509.hACF9HG20967@oobleck.astro.cornell.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Harrington wrote:

>>>During install of Fedora Core 1, Fedora Core test3, Red Hat 9, and
>>>Debian 3.0r1, the install fails at a random point, generally during
>>>the non-interactive package loading phase.  The most recent kernel
>>>with the problem is kernel-2.4.22-1.2115.nptl in the Fedora Core 1
>>>release.  The problem is 100% reproducible.
> 
> 
>>Hmm, I have installed Mandrake 9.1 on some Gigabyte KT600 motherboard
>>with no problems. It had 2.4.21 kernel.
> 
> 
>>Maybe you should check if there's a BIOS update for that MB?
> 
> 
> Yes, thanks, I did that before I posted.  The problem exists with both
> the original BIOS (1004) and the latest (1005).
> 
> Is anyone aware of similar problems with other manufacturers' KT600
> boards that were fixed in recent BIOS updates?  Perhaps Asus has a
> BIOS bug they haven't fixed yet.
> 
> By the way, I also underclocked both the CPU and the memory as far
> down as they would go, just to check, and the problem persisted.

Have you tried running with only one stick of memory ?

I have a Soyo KT600 board and it runs perfectly with one 512MiB PC3200
DIMM.

// Stefan

