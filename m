Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbUCaBvL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 20:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbUCaBvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 20:51:11 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26002 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261430AbUCaBvF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 20:51:05 -0500
Message-ID: <406A23FB.2050903@pobox.com>
Date: Tue, 30 Mar 2004 20:50:51 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jarno Paananen <jpaana@s2.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [sata] libata update
References: <4064E691.2070009@pobox.com> <4069FBC3.2080104@scssoft.com>	<4069FF46.7090604@pobox.com> <m34qs5iyes.fsf@kalahari.s2.org>
In-Reply-To: <m34qs5iyes.fsf@kalahari.s2.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jarno Paananen wrote:
> Jeff Garzik <jgarzik@pobox.com> writes:
> 
> 
>>Petr Sebor wrote:
>>
>>>Hi Jeff,
>>>I have upgraded from 2.6.3 to 2.6.5-rc3 and can't see the secondary
>>>sata drive anymore...
>>
>>Does this patch fix it?
> 
> 
> I'm using the 2.4 kernel version (would be using 2.6 if there was
> support for IT8212 ide-"raid" controller, hint hint Bart :) and had
> the same problem. This fixed it:


Sorry to be dumb, but just to clear...  you had the same problem, and 
the patch I posted fixed it?

	Jeff



