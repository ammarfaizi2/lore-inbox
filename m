Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262264AbVDFRwa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262264AbVDFRwa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 13:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262265AbVDFRwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 13:52:30 -0400
Received: from smtp-vbr11.xs4all.nl ([194.109.24.31]:42250 "EHLO
	smtp-vbr11.xs4all.nl") by vger.kernel.org with ESMTP
	id S262264AbVDFRwY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 13:52:24 -0400
In-Reply-To: <20050406173336.GA17413@wohnheim.fh-wedel.de>
References: <20050405164539.GA17299@kroah.com> <20050405164815.GI17299@kroah.com> <c8cb775b8f5507cbac1fb17b1028cffc@xs4all.nl> <200504052053.20078.blaisorblade@yahoo.it> <7aa6252d5a294282396836b1a27783e8@xs4all.nl> <20050406113233.GD7031@wohnheim.fh-wedel.de> <14410feafdb3a83e1ae457b93e593b81@xs4all.nl> <20050406122750.GE7031@wohnheim.fh-wedel.de> <20050406154648.GA28638@kroah.com> <c9f1f9c86f38a0dc3ff50ac93d2f9979@xs4all.nl> <20050406173336.GA17413@wohnheim.fh-wedel.de>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <09119e1fa05596980af4b69fb18637fa@xs4all.nl>
Content-Transfer-Encoding: 8BIT
Cc: jdike@karaya.com, Blaisorblade <blaisorblade@yahoo.it>,
       linux-kernel@vger.kernel.org, stable@kernel.org,
       Greg KH <gregkh@suse.de>
From: Renate Meijer <kleuske@xs4all.nl>
Subject: Re: [stable] Re: [08/08] uml: va_copy fix
Date: Wed, 6 Apr 2005 19:58:06 +0200
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Apr 6, 2005, at 7:33 PM, Jörn Engel wrote:

> On Wed, 6 April 2005 19:29:46 +0200, Renate Meijer wrote:
>>
>> I think its worth the time and trouble to take this up with the gcc
>> crowd. So if you could provide a list of things 3.3 misses, i'm sure
>> the gcc-crowd would like it.
>
> If you volunteer to do work with the gcc-crowd, I can dig up some old
> stuff and send you testcases.  Sure.

I'll volunteer. As I said, i think it's worth the time and trouble. But 
i can't do it on my own,
at least i need some backup from thee development community around 
here. You telling
me what's up, for one. I found one mail by Greg KH spelling out some of 
the problems, but you
suggest there's more to worry about.

Problem is, i'll be spending 5 weeks prety much scattered around 
europe, starting next friday and have
no idea on my online-ness yet. As it is, my trusty mac is my only 
digital companion, and my linux-box is in
storage for the time being.

So don't expect any results before May 17. But hey... Somebody has to 
do it. Just don't be surprised if the
folks at gcc do not agree with you "a prima vista". They may have a 
different idea on what exactly constitutes
a bug.

Upside is, i'll be taking my Mac anyway, so at least i'll have the 
sources handy. I'll start downloading tonight, so if you have data, 
please, lets have it.

Nevertheless, the points made in previous posts stand.


Regards,

Renate Meijer.
--

timeo hominem unius libri

Thomas van Aquino

