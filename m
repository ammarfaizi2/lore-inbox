Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbWEQQLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbWEQQLt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 12:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbWEQQLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 12:11:49 -0400
Received: from speedy.tutby.com ([195.137.160.40]:21450 "EHLO tut.by")
	by vger.kernel.org with ESMTP id S1750774AbWEQQLs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 12:11:48 -0400
Message-ID: <446B4B35.508@tut.by>
Date: Wed, 17 May 2006 19:11:33 +0300
From: Stas Myasnikov <myst@tut.by>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: linux cbon <linuxcbon@yahoo.fr>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: replacing X Window System !
References: <20060517154926.35649.qmail@web26606.mail.ukl.yahoo.com>
In-Reply-To: <20060517154926.35649.qmail@web26606.mail.ukl.yahoo.com>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>>> We dont need 2 kernels like today.
>>> All "dangerous code" should be in kernel.
>> The kernel is even more privileged than the X server
>> so putting
>> dangerous code there is counterproductive. Security
>> comes about through
>> intelligent design decisions, compartmentalisation,
>> isolation of
>> security critical code segments and the like. If you
>> merely put shit in
>> a different bucket you still have a bad smell.
> With "dangerous code" I meant : code which *could be
> potentially dangerous* like accessing directly the
> hardware etc.
> That code should be only in the kernel.

It's your opinion only.

Stas
