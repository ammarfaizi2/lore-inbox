Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbWAYVGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbWAYVGK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 16:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbWAYVGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 16:06:10 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:13587 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1751207AbWAYVGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 16:06:09 -0500
Message-ID: <43D7E83D.7040603@shadowen.org>
Date: Wed, 25 Jan 2006 21:06:05 +0000
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pekka Enberg <penberg@cs.helsinki.fi>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm3
References: <20060124232406.50abccd1.akpm@osdl.org>	 <43D785E1.4020708@shadowen.org>	 <84144f020601250644h6ca4e407q2e15aa53b50ef509@mail.gmail.com>	 <43D7AB49.2010709@shadowen.org> <1138212981.8595.6.camel@localhost>
In-Reply-To: <1138212981.8595.6.camel@localhost>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg wrote:
> On Wed, 2006-01-25 at 16:46 +0000, Andy Whitcroft wrote:
> 
>>Pekka Enberg wrote:
>>
>>>Does reverting the following patch make the panic go away?
>>>
>>>http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc1/2.6.16-rc1-mm3/broken-out/slab-cache_estimate-cleanup.patch
>>
>>No luck with that one ... I'll try the others you suggested.
> 
> 
> Does vanilla 2.6.16-rc1 work for you? The oops definitely makes me think
> it's slab related but the other patches don't seem likely suspects.

None of the other patches you suggested seem to be it either :/.  Yes
2.6.16-rc1 was ok on the boxs in question.

Cheers.

-apw
