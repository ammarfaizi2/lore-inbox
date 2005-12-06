Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932315AbVLFQoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbVLFQoY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 11:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbVLFQoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 11:44:24 -0500
Received: from ns2.lanforge.com ([66.165.47.211]:38090 "EHLO ns2.lanforge.com")
	by vger.kernel.org with ESMTP id S932307AbVLFQoX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 11:44:23 -0500
Message-ID: <4395BFBB.8060304@candelatech.com>
Date: Tue, 06 Dec 2005 08:43:39 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Jiri Benc <jbenc@suse.cz>, Christoph Hellwig <hch@infradead.org>,
       Joseph Jezak <josejx@gentoo.org>, mbuesch@freenet.de,
       linux-kernel@vger.kernel.org, NetDev <netdev@vger.kernel.org>
Subject: Re: Broadcom 43xx first results
References: <E1Eiyw4-0003Ab-FW@www1.emo.freenet-rz.de> <20051205190038.04b7b7c1@griffin.suse.cz> <4394892D.2090100@gentoo.org> <20051205195543.5a2e2a8d@griffin.suse.cz> <20051205191008.GA28433@infradead.org> <20051205203121.48241a08@griffin.suse.cz> <20051205194146.GA29317@infradead.org> <20051205211107.61941ab9@griffin.suse.cz> <20051206150909.GB1999@elf.ucw.cz>
In-Reply-To: <20051206150909.GB1999@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> 
>>>That's because you still don't get how we do development.  The last thing
>>>we want is full-scale rewrites.  Submit patches to fix things based on
>>>whatever you want but do it incremental.
>>
>>We have got almost finished and working stack. Everything we need to do
>>is:
>>1. identify issues;
>>2. fix the issues; some of them will need broader discussion;
>>3. split it into several (potentially a lot of) reviewable patches;
>>4. clean up the drivers.
>>
>>I'm in phase 2 now (no interesting results yet). I don't think it is
> 
> 
> No, it does not work like that. You don't get nice, reviewable,
> mergeable patches by developing code independently for 3 years or so
> then attempting merge.
> 
> If devicescape code is better than mainline, merge it _now_. If it is
> not, drop it and start from mainline code.

Merge now even if it breaks the current tree?  I for one would certainly
rather he finish his work on it and get it more polished.  Reviewing and
testing something that actually works would be a lot more fun...


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

