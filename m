Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751921AbWCAVVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921AbWCAVVG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 16:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751922AbWCAVVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 16:21:06 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:1193 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S1751921AbWCAVVF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 16:21:05 -0500
Message-ID: <44061035.20604@vilain.net>
Date: Thu, 02 Mar 2006 10:20:53 +1300
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tvrtko.ursulin@sophos.com
Cc: Arjan van de Ven <arjan@infradead.org>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] vfs: cleanup of permission()
References: <OF8335F2B0.0A730216-ON80257124.0045E22D-80257124.00475BA4@sophos.com>
In-Reply-To: <OF8335F2B0.0A730216-ON80257124.0045E22D-80257124.00475BA4@sophos.com>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tvrtko.ursulin@sophos.com wrote:
>>As external module, you have little say so far simply because your usage
>>isn't visible. I'd urge you to quickly submit your code so that the
>>things you need from this are better visible to the people who are
>>thinking and working on the redesign.
> I know all that, but it is a complicated matter to discuss. That's why I 
> was planning to make a comprehensive announcement which would discuss most 
> of the hot topics. Ideally yes, I would like to merge, but it won't happen 
> now. The first thing I would like to do is establish common ground with 
> other security vendors so that we could approach the problem together. 
> Personaly, I am not sure whether insisting that everything should be a 
> part of kernel is a right thing to do even though I think I understand all 
> the up- and down-sides of both policies.
> 
> Having said all this above, I am afraid that there will be no other choice 
> but to start working on the announcement asap. :)

Perhaps you can put up the work in progress on a git repository somewhere?

Sam.
