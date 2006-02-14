Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422696AbWBNRgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422696AbWBNRgX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 12:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422699AbWBNRgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 12:36:23 -0500
Received: from terminus.zytor.com ([192.83.249.54]:24548 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1422696AbWBNRgW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 12:36:22 -0500
Message-ID: <43F214F6.1070206@zytor.com>
Date: Tue, 14 Feb 2006 09:35:50 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
CC: linux-kernel@vger.kernel.org, jengelh@linux01.gwdg.de, drepper@redhat.com,
       austin-group-l@opengroup.org
Subject: Re: The naming of at()s is a difficult matter
References: <43EEACA7.5020109@zytor.com> <Pine.LNX.4.61.0602121137090.25363@yvahk01.tjqt.qr> <43F09320.nailKUSI1GXEI@burner> <Pine.LNX.4.61.0602140916440.7198@yvahk01.tjqt.qr> <43F1F2C2.nailMWZGOQDYR@burner> <43F1F56C.7000307@zytor.com> <43F20C95.nailMWZULDLNF@burner>
In-Reply-To: <43F20C95.nailMWZULDLNF@burner>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling wrote:
>>
>>Surely you're not suggesting that TOG's job is to rubber-stamp bad 
>>Solaris decisions...
> 
> Are you interested in forcing Solaris to change all interfaces?
> 

In this case, I think it would be entirely appropriate.  It's hardly a 
hardship to maintain the legacy names for backwards compatibility; since 
those names are nonsensical it is unlikely they'll ever want to be 
claimed, in which case they can be maintained indefinitely.

However, I would find it much, much worse if names that are *actively 
misleading and confusing* to the programmer would be included in an 
international standard and therefore forced upon the rest of the world 
forever.

	-hpa
