Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751001AbVK3FH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbVK3FH6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 00:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751002AbVK3FH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 00:07:58 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:12427 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751000AbVK3FH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 00:07:57 -0500
Date: Wed, 30 Nov 2005 00:07:55 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Gene's pcHDTV 3000 analog problem
In-reply-to: <438CFFAD.7070803@m1k.net>
To: linux-kernel@vger.kernel.org
Cc: Michael Krufky <mkrufky@m1k.net>, Kirk Lapray <kirk.lapray@gmail.com>,
       video4linux-list@redhat.com, CityK <CityK@rogers.com>,
       Perry Gilfillan <perrye@linuxmail.org>, Don Koch <aardvark@krl.com>
Message-id: <200511300007.56004.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200511282205.jASM5YUI018061@p-chan.krl.com>
 <c35b44d70511291548lcb10361ifd3a4ea0f239662d@mail.gmail.com>
 <438CFFAD.7070803@m1k.net>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 November 2005 20:26, Michael Krufky wrote:

[...]

>All I can think of doing next is to have Gene, Don or Perry do a
>bisection test on our cvs repo.... checking out different cvs revisions
>until we can narrow it down to the day the problem patch was applied.
>
>::sigh::

A sigh?  More like an 'oh fudge' or whatever your fav expletive deleted
is...

>Who wants to do it?  I'll give you detailed instructions if you're
> willing.
>
>Regards,
>Mike

Can you farm it out, one set of patches to each of us?  Or do you want
to setup a seperate cvs tree based on the v4l code in 2.6.14.3, and
incrementally patch it as we each report its still ok, until it breaks
again?  I think I'd prefer the latter so we are all near the same
page even if it takes 3x longer to arrive at the answer.  How many
actual patches in terms of dependency groups are there?  I know, I
coulda went all week without asking that :(

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.36% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.

