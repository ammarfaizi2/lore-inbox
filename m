Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751443AbWHDSwJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbWHDSwJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 14:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbWHDSwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 14:52:09 -0400
Received: from terminus.zytor.com ([192.83.249.54]:56511 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751443AbWHDSwH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 14:52:07 -0400
Message-ID: <44D39735.8010909@zytor.com>
Date: Fri, 04 Aug 2006 11:51:33 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Jes Sorensen <jes@sgi.com>
CC: Andreas Schwab <schwab@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeff Garzik <jeff@garzik.org>, ricknu-0@student.ltu.se,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] A generic boolean
References: <1153341500.44be983ca1407@portal.student.luth.se>	<44BE9E78.3010409@garzik.org> <yq0lkq4vbs3.fsf@jaguar.mkp.net>	<1154702572.23655.226.camel@localhost.localdomain>	<44D35B25.9090004@sgi.com>	<1154706687.23655.234.camel@localhost.localdomain>	<44D36E8B.4040705@sgi.com> <je4pws1ofb.fsf@sykes.suse.de>	<44D370ED.2050605@sgi.com> <jezmekzdb5.fsf@sykes.suse.de>	<44D3753B.1060403@sgi.com> <je3bccmoab.fsf@sykes.suse.de> <44D39658.9080007@sgi.com>
In-Reply-To: <44D39658.9080007@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes Sorensen wrote:
>
>> That's how the ABI is defined.
> 
> That the ABI for long long or the ABI for uint64_t? Given that u64 is a
> Linux thing, it ought to be ok to do the alignment the right way within
> the kernel.
> 

And what will break if you make that switch?

	-hpa
