Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbUD1WvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbUD1WvX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 18:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbUD1WvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 18:51:23 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:38927 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S261505AbUD1WvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 18:51:21 -0400
Message-ID: <40903669.5070600@techsource.com>
Date: Wed, 28 Apr 2004 18:55:37 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Paulo Marques <pmarques@grupopie.com>,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
       Jan-Benedict Glaw <jbglaw@lug-owl.de>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
References: <408DC0E0.7090500@gmx.net> <Pine.LNX.4.58.0404262116510.19703@ppc970.osdl.org> <1083045844.2150.105.camel@bach> <20040427092159.GC29503@lug-owl.de> <408E37D9.7030804@gmx.net> <408E5944.8090807@grupopie.com> <20040427185800.GS2595@openzaurus.ucw.cz>
In-Reply-To: <20040427185800.GS2595@openzaurus.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Pavel Machek wrote:
> Hi!
> 
> 
>>The way I see it, they know a C string ends with a '\0'. This is like 
>>saying that a English sentence ends with a dot. If they wrote "GPL\0" 
>>they are effectively saying that the license *is* GPL period.
> 
> 
> If you use modinfo, license probably will be displayed as GPL.
> I'd guess that sending bunch of lawyers their way is right solution.


The very fact that someone who represents the company is willing to talk 
to us on LKML should be mega points in their favor.

Yes, they did something wrong, but they're giving us the time of day, 
something a lot of companies don't do until the FSF has been hounding 
them for a year.

