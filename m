Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932767AbVITOlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932767AbVITOlm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 10:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932769AbVITOll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 10:41:41 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:2249 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S932767AbVITOll
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 10:41:41 -0400
Message-ID: <43301FA0.7030906@slaphack.com>
Date: Tue, 20 Sep 2005 09:41:36 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Macintosh/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Hans Reiser <reiser@namesys.com>, Horst von Brand <vonbrand@inf.utfsm.cl>,
       thenewme91@gmail.com, Christoph Hellwig <hch@infradead.org>,
       Denis Vlasenko <vda@ilport.com.ua>, chriswhite@gentoo.org,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
References: <200509182004.j8IK4JNx012764@inti.inf.utfsm.cl> <432E5024.20709@namesys.com> <20050920075133.GB4074@elf.ucw.cz>
In-Reply-To: <20050920075133.GB4074@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> 
>>V3 is obsoleted by V4 in every way.  V3 is old code that should be
>>marked as deprecated as soon as V4 has passed mass testing.   V4 is far
>>superior in its coding style also.  Having V3 in and V4 out is at this
>>point just stupid. 
> 
> 
> Really? Last time I checked, even V3's fsck was not too great. [In
> fact I never could make it run stable enough to even _test_ it
> properly].
> 
> Do you have working fsck for V4?

Already saved me once.  But then, I should have had backups.

And personally, if it was my FS, I'd stop working on fsck after it was 
able to "check".  That's what it's for.  To fix an FS, you wipe it and 
restore from backups.
