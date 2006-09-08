Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751942AbWIHA0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751942AbWIHA0K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 20:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751944AbWIHA0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 20:26:10 -0400
Received: from main.gmane.org ([80.91.229.2]:46484 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751942AbWIHA0I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 20:26:08 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: David Abrahams <dave@boost-consulting.com>
Subject: Re: prepatching errors
Date: Thu, 07 Sep 2006 20:26:02 -0400
Message-ID: <87k64fxkyt.fsf@pereiro.peloton>
References: <87k64fz0nj.fsf@pereiro.peloton> <Pine.LNX.4.64.0609071903400.32079@turbotaz.ourhouse> <87pse7xl8o.fsf@pereiro.peloton>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 216-15-125-177.c3-0.smr-ubr3.sbo-smr.ma.cable.rcn.com
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.0 (gnu/linux)
Cancel-Lock: sha1:7/FP1XBwDGBV0j6Iqu7+QcZtDNk=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Abrahams <dave@boost-consulting.com> writes:

> Chase Venters <chase.venters@clientec.com> writes:
>
>> On Thu, 7 Sep 2006, David Abrahams wrote:
>>
>>>
>>> Hi,
>>>
>>> I'm trying to apply the 2.6.18-rc6 prepatch (from
>>> http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.18-rc6.bz2)
>>> to the 2.6.17.11 sources (from
>>> http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.17.11.tar.bz2) using
>>
>> David,
>> 	The -rc series patches should be applied to the last mainline (not
>> -stable) release. In your case, you want to patch 2.6.17.
>
> Oooooh!

BTW, it might be a good idea to put a link to the latest mainline
sources right on the front page of kernel.org where I found the
prepatch.  Along with note in the prepatch row saying "apply to 2.6.17
sources," that would have saved y'all having to answer my dumb query.

Thanks again,
-- 
Dave Abrahams
Boost Consulting
www.boost-consulting.com

