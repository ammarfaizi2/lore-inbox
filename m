Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933080AbWKMVoB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933080AbWKMVoB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 16:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933083AbWKMVoB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 16:44:01 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:62952
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S933080AbWKMVoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 16:44:00 -0500
Message-ID: <4558E652.1080905@microgate.com>
Date: Mon, 13 Nov 2006 15:40:34 -0600
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Krzysztof Halasa <khc@pm.waw.pl>
CC: Jeff Garzik <jeff@garzik.org>,
       =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Re: linux-2.6.19-rc5-g088406bc build #120 failed
References: <200611130943.42463.toralf.foerster@gmx.de>	<4558860B.8090908@garzik.org> <45588895.7010501@microgate.com>	<m3ejs78adt.fsf@defiant.localdomain> <4558BF72.2030408@microgate.com> <m3ac2v6phw.fsf@defiant.localdomain>
In-Reply-To: <m3ac2v6phw.fsf@defiant.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa wrote:
>>We were in a perpetual state of:
>>
>>1. supply patch
>>2. get criticism from new person just joining thread
>>3. change patch to address criticism
>>4. goto #1
> 
> 
> Right, the description fits. OTOH I recall the criticism had a fair
> amount of merit. That's how the things work here. Been there many
> times BTW.

To be more precise, that is many distinct
criticisms from distinct people, some of which
contradict each other.

I know code is open to criticism,
but after several weeks of submitting patches
and getting no closer to acceptance I gave up.
We were going around in circles where one person
wanted some thing that conflicted with what
another person wanted.

>>But since we seem stuck in a state where real fixes
>>are not allowed, and this breakage is constantly reintroduced,
> 
> It may look like that sometimes but it's not real. Anyway I think
> everyone would benefit from the correct fix and the issue wouldn't
> come again. Having looked at it I'd fix it myself but I'm pretty
> sure you still have the old patch (which changes CONFIG_ macros
> outside Kconfig, I mean in .c files) and it could be trivially
> modified then applied (and perhaps tested with real hardware if
> needed).

There isn't much point in resubmitting the previously
rejected patches only to be rejected again.

I was planning on trying again in a month or two
to see if all the people who rejected all of the
previous patches have come to some sort of agreement.

Without such agreement we are left in the state
of never ending patches.

-- 
Paul Fulghum
Microgate Systems, Ltd.
