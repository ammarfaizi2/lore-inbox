Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263162AbUJ2Rxj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263162AbUJ2Rxj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 13:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263438AbUJ2Rxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 13:53:36 -0400
Received: from holomorphy.com ([207.189.100.168]:27283 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263162AbUJ2RuM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 13:50:12 -0400
Date: Fri, 29 Oct 2004 10:49:51 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       "michael@optusnet.com.au" <michael@optusnet.com.au>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>,
       Massimo Cetra <mcetra@navynet.it>, Ed Tomlinson <edt@aei.ca>,
       "Marcos D. Marado Torres" <marado@student.dei.uc.pt>,
       John Richard Moser <nigelenki@comcast.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: My thoughts on the "new development model"
Message-ID: <20041029174951.GC12934@holomorphy.com>
References: <200410280907_MC3-1-8D5A-FF57@compuserve.com> <20041028150329.GK12934@holomorphy.com> <4182436B.20600@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4182436B.20600@tmr.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> users with anything but the crappiest x86 s**tboxen and a tiny subset
>> of all drivers (arjan's 20) are hopelessly outnumbered.

On Fri, Oct 29, 2004 at 09:19:39AM -0400, Bill Davidsen wrote:
> Sorry, i386 is really a pool of Pentium, Athlon, and Opteron chips, with 
> a witches brew of HT, 64bit extensions to 32 bit chips, and the like. 
> Connected by a constantly changing set of Intel, SiS, VIA and other 
> shipsets, and getting storage from IDE and SATA drives.
> Not to mention using a vast array of CD and DVD drives and several major 
> flavors of USB methods with minor variations of each, and driving their 
> consoles with at least a half-dozen popular video chipsets with drivers 
> of various shades of openness.
> You don't even reach 99.99% with small-endian, there are more assorted 
> RISC chips in use than that. I guess you're safe with twos complement 
> arithmetic, although I cringed at Linus' recent "find a power of two" 
> code which depends on it.  Diversity, thy name is Linux!

Feel free to compile real statistics on in-the-field Linux code use.
I'll go with my handwavy assessment until I see such.


-- wli
