Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267563AbUIDKpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267563AbUIDKpW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 06:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267657AbUIDKpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 06:45:22 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:62634 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267563AbUIDKpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 06:45:17 -0400
Message-ID: <41399CA2.3080607@yahoo.com.au>
Date: Sat, 04 Sep 2004 20:44:50 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Whitwell <keith@tungstengraphics.com>
CC: Christoph Hellwig <hch@infradead.org>, Dave Airlie <airlied@linux.ie>,
       Jon Smirl <jonsmirl@yahoo.com>, dri-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: New proposed DRM interface design
References: <20040904004424.93643.qmail@web14921.mail.yahoo.com> <Pine.LNX.4.58.0409040145240.25475@skynet> <20040904102914.B13149@infradead.org> <41398EBD.2040900@tungstengraphics.com> <20040904104834.B13362@infradead.org> <413997A7.9060406@tungstengraphics.com> <20040904112535.A13750@infradead.org> <4139995E.5030505@tungstengraphics.com>
In-Reply-To: <4139995E.5030505@tungstengraphics.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Whitwell wrote:
> Christoph Hellwig wrote:
> 
>> On Sat, Sep 04, 2004 at 11:23:35AM +0100, Keith Whitwell wrote:
>>
>>>> Actually regulat users do.  And they do by pulling an uptodate 
>>>> kernel or
>>>> using a vendor kernel with backports.  This model would work for 
>>>> video drivers
>>>> aswell.
>>>
>>>
>>> Sure, explain to me how I should upgrade my RH-9 system to work on my 
>>> new i915?
>>
>>
>>
>> Download a new kernel.org kernel or petition the fedora legacy folks to
>> include a drm update.  The last release RH-9 kernel has various security
>> and data integrity issues anyway, so you'd be a fool to keep running it.
> 
> 
> OK, I've found www.kernel.org, and clicked on the 'latest stable kernel' 
> link.  I got a file called "patch-2.6.8.1.bz2".  I tried to install this 
> but nothing happened.  My i915 still doesn't work.  What do I do now?
> 

Just out of interest, what would the scenario be if you do if you could
get a compatible driver?
