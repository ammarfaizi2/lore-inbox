Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261650AbSJYXP5>; Fri, 25 Oct 2002 19:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261661AbSJYXP5>; Fri, 25 Oct 2002 19:15:57 -0400
Received: from oak.sktc.net ([208.46.69.4]:38104 "EHLO oak.sktc.net")
	by vger.kernel.org with ESMTP id <S261650AbSJYXP5>;
	Fri, 25 Oct 2002 19:15:57 -0400
Message-ID: <3DB9D1FE.5010607@sktc.net>
Date: Fri, 25 Oct 2002 18:21:34 -0500
From: "David D. Hagood" <wowbagger@sktc.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021012
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: "Nakajima, Jun" <jun.nakajima@intel.com>, Robert Love <rml@tech9.net>,
       Daniel Phillips <phillips@arcor.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "'Dave Jones'" <davej@codemonkey.org.uk>,
       "'akpm@digeo.com'" <akpm@digeo.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'chrisl@vmware.com'" <chrisl@vmware.com>,
       "'Martin J. Bligh'" <mbligh@aracnet.com>
Subject: Re: [PATCH] hyper-threading information in /proc/cpuinfo
References: <F2DBA543B89AD51184B600508B68D4000ECE7086@fmsmsx103.fm.intel.com> <3DB9CC5D.7000600@pobox.com>
In-Reply-To: <F2DBA543B89AD51184B600508B68D4000ECE7086@fmsmsx103.fm.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

>
> "sibling" makes a lot more sense from an English language perspective.
>
Might I suggest "subcore", since that's really what it is - a sub-core 
in the main chip.

My siblings are distinct entities from me, my sub-parts aren't.
(now, were I part of a cojoined twin....)

