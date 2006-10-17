Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161211AbWJQKjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161211AbWJQKjm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 06:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161212AbWJQKjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 06:39:42 -0400
Received: from vms048pub.verizon.net ([206.46.252.48]:10347 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S1161211AbWJQKjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 06:39:41 -0400
Date: Tue, 17 Oct 2006 06:39:38 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: raw1394 problems galore FIXED!!!!!
In-reply-to: <4534755B.2000804@s5r6.in-berlin.de>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: For users of Fedora Core releases <fedora-list@redhat.com>,
       linux-kernel@vger.kernel.org, linux1394-user@lists.sourceforge.net
Message-id: <4534B2EA.1040309@verizon.net>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <4532DF11.9060704@verizon.net> <4533B889.5060302@s5r6.in-berlin.de>
 <4533DDA2.2050008@verizon.net> <4533FBD8.7050101@s5r6.in-berlin.de>
 <45342789.2050506@verizon.net> <453440C7.2060800@verizon.net>
 <4534755B.2000804@s5r6.in-berlin.de>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Richter wrote:
> Gene Heskett wrote:
> ..
>> Tonight, I saw that kernel-2.6.18-1.2200.fc5.i686 was available, along
>> with the matching kmod-ndiswrapper pieces and kmod-ntfs in versions
>> 2.6.18-1.2200.fc5 were available, so I installed them and rebooted.
>>
>> Now kino-0.8 works sortof, wants to crash.
>> And kino-0.9.2 apparently works flawlessly, as does dvcont.
> ...
>> So it was a kernel problem all along!
> ...
> 
> I have no idea what we did between 2.6.17 and .18 that made it work. Or
> was it just the reboot after kernel update which brought it into shape?

It was rebooted many times on the previous kernel.  This kernel also 
'feels' considerably faster.

-- 
Cheers, Gene

