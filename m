Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbUCaBzS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 20:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbUCaBzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 20:55:18 -0500
Received: from s2.org ([195.197.64.39]:62850 "EHLO kalahari.s2.org")
	by vger.kernel.org with ESMTP id S261611AbUCaBzJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 20:55:09 -0500
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [sata] libata update
References: <4064E691.2070009@pobox.com> <4069FBC3.2080104@scssoft.com>
	<4069FF46.7090604@pobox.com> <m34qs5iyes.fsf@kalahari.s2.org>
	<406A23FB.2050903@pobox.com>
From: Jarno Paananen <jpaana@s2.org>
Date: Wed, 31 Mar 2004 04:53:50 +0300
In-Reply-To: <406A23FB.2050903@pobox.com> (Jeff Garzik's message of "Tue, 30
 Mar 2004 20:50:51 -0500")
Message-ID: <m3wu51hjdd.fsf@kalahari.s2.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> writes:

> Jarno Paananen wrote:
>> Jeff Garzik <jgarzik@pobox.com> writes:
>>
>>>Petr Sebor wrote:
>>>
>>>>Hi Jeff,
>>>>I have upgraded from 2.6.3 to 2.6.5-rc3 and can't see the secondary
>>>>sata drive anymore...
>>>
>>>Does this patch fix it?
>> I'm using the 2.4 kernel version (would be using 2.6 if there was
>> support for IT8212 ide-"raid" controller, hint hint Bart :) and had
>> the same problem. This fixed it:
>
>
> Sorry to be dumb, but just to clear...  you had the same problem, and
> the patch I posted fixed it?

Yes, exactly, sorry for the confusion.

// Jarno
