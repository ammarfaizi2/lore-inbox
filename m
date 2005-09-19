Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932645AbVISVzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932645AbVISVzU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 17:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932659AbVISVzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 17:55:20 -0400
Received: from rwcrmhc13.comcast.net ([216.148.227.118]:42682 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932645AbVISVzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 17:55:19 -0400
Message-ID: <432F33C8.90908@namesys.com>
Date: Mon, 19 Sep 2005 14:55:20 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Denis Vlasenko <vda@ilport.com.ua>, Christoph Hellwig <hch@infradead.org>,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
References: <432AFB44.9060707@namesys.com> <200509171415.50454.vda@ilport.com.ua> <200509180934.50789.chriswhite@gentoo.org> <200509181321.23211.vda@ilport.com.ua> <432F18DF.6020903@tmr.com>
In-Reply-To: <432F18DF.6020903@tmr.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:

> Denis Vlasenko wrote:
>
>>
>> Maybe xfs shouldn't be accepted too, this may be an answer.
>
>
> That argument is specious, and raises the chance that someone will
> suggest that we learn from our mistakes.

It wasn't a mistake to accept xfs, xfs is a great piece of technology. 
I haven't monitored their progress, but I am sure that they are
diligently fixing bugs as they are reported.  Guys, making a filesystem
stable is hard, and once every known test passes without crashing, there
is no substitute for masses of users finding bugs not hit by the tests,
and getting them fixed.  My point is merely that Hellwig could go and
find flaws in the filesystem he worked on, XFS, if he chose to.  I think
he should.

