Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261895AbVACWEb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbVACWEb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 17:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbVACWEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 17:04:30 -0500
Received: from simmts5.bellnexxia.net ([206.47.199.163]:48581 "EHLO
	simmts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261895AbVACWDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 17:03:20 -0500
Message-ID: <36594.10.10.10.28.1104789706.squirrel@linux1>
In-Reply-To: <0F9DCB4E-5DD1-11D9-892B-000D9352858E@mac.com>
References: <200501032059.j03KxOEB004666@laptop11.inf.utfsm.cl>
    <0F9DCB4E-5DD1-11D9-892B-000D9352858E@mac.com>
Date: Mon, 3 Jan 2005 17:01:46 -0500 (EST)
Subject: Re: starting with 2.7
From: "Sean" <seanlkml@sympatico.ca>
To: "Felipe Alfaro Solana" <lkml@mac.com>
Cc: "Horst von Brand" <vonbrand@inf.utfsm.cl>, "Adrian Bunk" <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, "Rik van Riel" <riel@redhat.com>,
       "William Lee Irwin III" <wli@holomorphy.com>,
       "Maciej Soltysiak" <solt2@dns.toxicfilms.tv>,
       "Andries Brouwer" <aebr@win.tue.nl>,
       "William Lee Irwin III" <wli@debian.org>
User-Agent: SquirrelMail/1.4.3a-7
X-Mailer: SquirrelMail/1.4.3a-7
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, January 3, 2005 4:47 pm, Felipe Alfaro Solana said:
> On 3 Jan 2005, at 21:59, Horst von Brand wrote:
>
>> Felipe Alfaro Solana <lkml@mac.com> said:
>>
>> [...]
>>
>>> I would like to comment in that the issue is not exclusively targeted
>>> to stability, but the ability to keep up with kernel development. For
>>> example, it was pretty common for older versions of VMWare and NVidia
>>> driver to break up whenever a new kernel version was released.
>>
>> That is the price for closed-source drivers.
>>
>>> I think it's a PITA for developers to rework some of the closed-source
>>> code to adopt the new changes in the Linux kernel.
>>
>> Open up the code. Most of the changes will then be done as a matter of
>> course by others.
>
> Unfortunately, you can't force the entire hardware industry to open up
> their drivers.
>

The point is, they'll have to deal with the burrden of any extra work
created as a result.   It's not the responsibility of the open source
developers.   Smart users pick hardware that is well supported by Linux
and doesn't run the risk of becoming obsolete the day the manufacturer
decides they don't want to provide drivers any longer.

Sean



