Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161092AbWF0PWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161092AbWF0PWo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 11:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161094AbWF0PWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 11:22:44 -0400
Received: from wasp.net.au ([203.190.192.17]:40628 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S1161092AbWF0PWo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 11:22:44 -0400
Message-ID: <44A14D3D.8060003@wasp.net.au>
Date: Tue, 27 Jun 2006 19:22:37 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Nigel Cunningham <ncunningham@linuxmail.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       suspend2-devel@lists.suspend2.net
Subject: Re: [Suspend2-devel] Re: Suspend2 - Request for review & inclusion
 in	-mm
References: <200606270147.16501.ncunningham@linuxmail.org> <20060627133321.GB3019@elf.ucw.cz>
In-Reply-To: <20060627133321.GB3019@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
>> Some of the advantages of suspend2 over swsusp and uswsusp are:
>>
>> - Speed (Asynchronous I/O and readahead for synchronous I/O)
> 
> uswsusp should be able to match suspend2's speed. It can do async I/O,
> etc...

ARGH!

And the next version of windows will have all the wonderful features that MacOSX has now so best not 
upgrade to Mac as you can just wait for the next version of windows.

suspend2 has it *now*. It works, it's stable.

uswsusp is a great idea, really.. I love it.. but suspend2 is here, it works, it's stable and it's 
now. Why continue to deprive the mainstream of these features because "uswsusp should".. as yet it 
doesn't.. and when it does then we can phase out the currently stable, working alternative that has 
all these features that uswsusp _will_ have, after it's had them for a year or so and its been 
proven stable. Not only that, I'll be happy to migrate over to it. Until then however, you can pry 
suspend2.. cold, dead.. blah blah..

Honestly, I have given up worrying if it's in-kernel or not. Nigel makes it so easy to apply the 
patches to the current kernels it's a doddle in any case, however I'm sure it would be much easier 
on everyone if it were in the tree.

Brad (suspend user since 2.2.17 - and suspend2 is a heck of a lot more reliable/usable than the 
in-kernel version ever has been for me)
-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
