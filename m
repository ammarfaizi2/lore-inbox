Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263025AbTDVJW7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 05:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263026AbTDVJW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 05:22:59 -0400
Received: from iits0165.inlink.com ([209.135.140.65]:36303 "EHLO
	vs365.rosehosting.com") by vger.kernel.org with ESMTP
	id S263025AbTDVJW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 05:22:58 -0400
Message-ID: <38291.207.172.171.44.1051004102.squirrel@miallen.com>
In-Reply-To: <200304221006.09601.m.c.p@wolk-project.de>
References: <20030422034821.6a57acc0.mba2000@ioplex.com> 
     <200304221006.09601.m.c.p@wolk-project.de>
Date: Tue, 22 Apr 2003 05:35:02 -0400 (EDT)
Subject: Re: What's the deal McNeil? Bad interactive behavior in X w/ RH's 
     2.4.18
From: "Michael B Allen" <mba2000@ioplex.com>
To: "Marc-Christian Petersen" <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.0-1.7.x
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tuesday 22 April 2003 09:48, Michael B Allen wrote:
>
> Hi Michael,
>
>> I'm running Red Hat 7.3 with their stock 2.4.18-3 kernel on an IBM
>> T30. Once every few hours X locks up for 5-10 seconds while the disk
>> grinds. If I type in an Xterm the characters are not echoed until the
<snip>
>> I would like very much for this behavior to go away as it is extremely
>> annoying. If there is a patch please let me know where I can get it.
> There are some hacks. One by Andrea Arcangeli, one by Neil Schemenauer and
> one
> by Con Kolivas and me. Search the archives please (lowlat elevator/io
> scheduler)

Ok, I searched a little using the Googler at indiana.edu's archives but
nothing jumped up and bit me. I'm not too excited about applying a patch
snarfed out of an e-mail anywat. I'm surprised no one else has not
complained about this enough to the point where you guys don't have a
canned answer with a link. Is this problem not considered important?

Does anyone know which RH patch in the 2.4.18-10 RPM adds this elevator
throughput "improvement"? What identifiers would such a patch have in it?

Thanks,
Mike

PS: Why are there only "hacks"? Is this not considered important?
