Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbUCGDGZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 22:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbUCGDGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 22:06:24 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:50683 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S261745AbUCGDGX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 22:06:23 -0500
Message-ID: <404A919C.3070501@matchmail.com>
Date: Sat, 06 Mar 2004 19:06:04 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steve Longerbeam <stevel@mvista.com>
CC: Dave Jones <davej@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: new special filesystem for consideration in 2.6/2.7
References: <40462AA1.7010807@mvista.com> <4048C245.7060009@mvista.com> <20040305184203.GB26176@redhat.com> <4048CE25.8010705@mvista.com>
In-Reply-To: <4048CE25.8010705@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Longerbeam wrote:
> 
> 
> Dave Jones wrote:
> 
>> On Fri, Mar 05, 2004 at 10:09:09AM -0800, Steve Longerbeam wrote:
>> > >An intro to PRAMFS along with a technical specification
>> > >is at the SourceForge project web page at
>> > >http://pramfs.sourceforge.net/. A patch for 2.6.3 has
>> > >been released at the SF project site. > > > A new patch for 2.6.4 
>> is available, but it and the 2.6.3 patch
>> > are each ~2900 lines, so I won't post here. But here's the intro:
>>
>> Without commenting on the code, the biggest thing holding back
>> inclusion of this is likely the comment about there likely being
>> patents held on parts of that code.
>>
>>         Dave
>>
> 
> Dave, true MV has a patent pending, but it would only affect any future use
> of the technology in a _non GPL_ operating system. Used in Linux or any
> future GPL software, no patent licenses or royalties are involved at all.

A statement in legal terms should be in the patch.
