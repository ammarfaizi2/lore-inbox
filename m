Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262383AbSKDMSm>; Mon, 4 Nov 2002 07:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264658AbSKDMSm>; Mon, 4 Nov 2002 07:18:42 -0500
Received: from mailout08.sul.t-online.com ([194.25.134.20]:40579 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262383AbSKDMSl>; Mon, 4 Nov 2002 07:18:41 -0500
Cc: linux-kernel@vger.kernel.org
References: <Pine.GSO.4.21.0211030048170.25010-100000@steklov.math.psu.edu>
	<1036307763.31699.214.camel@thud>
	<slrnascf7j.5nn.asalmela@pan.pressi.com>
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
To: Antti Salmela <asalmela@iki.fi>
Subject: Re: Filesystem Capabilities in 2.6?
Date: Mon, 04 Nov 2002 13:24:57 +0100
Message-ID: <874raxh692.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Antti Salmela <asalmela@iki.fi> writes:

> Dax Kelson <dax@gurulabs.com> wrote:
>
>> Each app should run in its own security context by itself.  That is why
>> I have all the following users in my /etc/passwd:
>> 
>> apache nscd squid xfs ident rpc pcap nfsnobody radvd gdm named ntp
>
> Well, wouldn't it be then logical to associate uids to capabilities, e.g. I
> could have ping binary setuid to user ping which would have just the
> necessary capabilities to operate?

Welcome to accessfs :-)

<http://groups.google.com/groups?selm=87k7km9fti.fsf%40goat.bogus.local>
<http://groups.google.com/groups?selm=87elau9ft2.fsf%40goat.bogus.local>
<http://groups.google.com/groups?selm=878z129fnz.fsf%40goat.bogus.local>

It's not exactly what you asked for, but I think it's the closest you
can get at the moment.

Regards, Olaf.
