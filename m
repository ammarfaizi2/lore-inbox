Return-Path: <linux-kernel-owner+w=401wt.eu-S1754556AbWLYXHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754556AbWLYXHK (ORCPT <rfc822;w@1wt.eu>);
	Mon, 25 Dec 2006 18:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754573AbWLYXHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Dec 2006 18:07:09 -0500
Received: from squawk.glines.org ([72.36.206.66]:60773 "EHLO squawk.glines.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754556AbWLYXHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Dec 2006 18:07:09 -0500
Message-ID: <45905997.5080403@glines.org>
Date: Mon, 25 Dec 2006 15:07:03 -0800
From: Mark Glines <mark@glines.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20061221)
MIME-Version: 1.0
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
CC: linuxppc-dev@ozlabs.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]  powerpc: linkstation uses uimage style zImages
References: <fa.ne7N9dqjDz5qS4D/fowPKdPc4ZY@ifi.uio.no> <fa.pM17YEcICUlveSt/vbSKGv6sFWk@ifi.uio.no> <45902A6F.4000100@glines.org> <Pine.LNX.4.60.0612252128530.3424@poirot.grange> <459046FE.9030008@glines.org> <Pine.LNX.4.60.0612252349040.3424@poirot.grange>
In-Reply-To: <Pine.LNX.4.60.0612252349040.3424@poirot.grange>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guennadi Liakhovetski wrote:
> Mark
> 
> Thanks for the patch. Are you actually going to test this kernel on a real 
> hardware or just testing builds? If it is going to be a real life test, 
> I'd be interested to know what exactly hardware, U-boot version, dts, and 
> what results.

Yes, I do very much intend to test it on real hardware.  I have a couple 
of Kurobox HGs which desperately need a 21st century kernel.  I still 
need to install U-boot on it, but first I'm just going to test the 
vmlinux with the loader.o kernel module.  (And my rs232 voltage 
converters haven't gotten here yet, so I'm being a little conservative 
about all of this.)


> BTW, ack-ing your patch would be a bit easier if you sent it inline.

Yeah, thunderbird sucks for this stuff.  Keep nagging me and I'll set up 
mutt again. :)  Thanks!

Mark
