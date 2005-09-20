Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932782AbVITRqG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932782AbVITRqG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 13:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932786AbVITRqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 13:46:06 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:63206 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932785AbVITRqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 13:46:04 -0400
Message-ID: <43304ADC.7000603@namesys.com>
Date: Tue, 20 Sep 2005 10:46:04 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nikita Danilov <nikita@clusterfs.com>
CC: Lorenzo Allegrucci <l.allegrucci@gmail.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, thenewme91@gmail.com,
       Christoph Hellwig <hch@infradead.org>,
       Denis Vlasenko <vda@ilport.com.ua>, chriswhite@gentoo.org,
       lkml <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Nate Diller <ndiller@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
References: <200509180934.50789.chriswhite@gentoo.org>	<432FC150.9020807@namesys.com>	<20050920114253.GL10845@suse.de>	<200509201530.01808.l.allegrucci@gmail.com> <17200.5343.908617.558388@gargle.gargle.HOWL>
In-Reply-To: <17200.5343.908617.558388@gargle.gargle.HOWL>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov wrote:

>Lorenzo Allegrucci <l.allegrucci@gmail.com> writes:
>
>[...]
>
>  
>
>>Why not just rename the kernel option "elevator" to "iosched" ?
>>    
>>
>
>At least update Documentation/kernel-parameters.txt to be consistent,
>but I think kernel boot options are considered to be a part of the "user
>space API" and, as such, cannot be changed that easily.
>
>Nikita.
>
>
>  
>
You could make both names work, and then deprecate "elevator".....
