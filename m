Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267469AbUIKGEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267469AbUIKGEr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 02:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267578AbUIKGEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 02:04:47 -0400
Received: from wasp.net.au ([203.190.192.17]:1679 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S267469AbUIKGEq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 02:04:46 -0400
Message-ID: <4142957B.30605@wasp.net.au>
Date: Sat, 11 Sep 2004 10:04:43 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Mozilla Thunderbird 0.7+ (X11/20040730)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrey Panin <pazke@donpac.ru>
CC: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: netwinder or ARM build platform
References: <200409091759.i89HxHI2023135@work.bitmover.com> <20040910065107.GE692@pazke>
In-Reply-To: <20040910065107.GE692@pazke>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Panin wrote:
> On 253, 09 09, 2004 at 10:59:17AM -0700, Larry McVoy wrote:
> 
>>BK found another bad hard drive today, on our netwinder.  The disk is dieing
>>badly unfortunately and I don't have installation media for this beast.
>>I suspect I can go find it but does anyone know of a faster build platform
>>for arm?  Russell uses bk on arms (no kidding, that's amazing) and so we
>>continue to support it but that netwinder is just amazingly slow.  If there
>>is a faster platform we want one.
> 
> 
> What about these beasts http://www.iyonix.com/ ?
> 

I don't know about the netwinder, but I do a lot of native builds on my iPAQ 5550 (400MHz 128MB Ram) 
using a full debian install chroot over nfs with a PCMCIA network card. It's solid and reliable anyway.

Regards,
Brad
