Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbWCWDSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbWCWDSU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 22:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbWCWDSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 22:18:20 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:39813 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S932139AbWCWDSS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 22:18:18 -0500
Message-ID: <4422136A.9030604@vilain.net>
Date: Thu, 23 Mar 2006 15:18:02 +1200
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: vger ate my patch!
References: <20060322061333.27638.63963.stgit@localhost.localdomain> <20060322115041.GB21614@mea-ext.zmailer.org>
In-Reply-To: <20060322115041.GB21614@mea-ext.zmailer.org>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matti Aarnio wrote:

>>And if my theory is correct, this message will also not make it to LKML.
>>    
>>
>Hmm..  Yes it did...   I found them in junk-pile, and the reason was:
>  
>

Thanks for that diagnostic, Matti. I had considered that the reason
might have been something to do with the recipients, but thought that a
binary search involving them would have been a tad rude.

>Your MUA software doesn't do proper text element quoting, when said
>element has RFC-822 specials in it.
>  
>

Yes, I was hand editing the mbox file produced by `stg mail'. That'll
learn me :-)

Sam.

