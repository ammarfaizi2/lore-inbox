Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964891AbVHIRJr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964891AbVHIRJr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 13:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964892AbVHIRJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 13:09:46 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:15385 "EHLO
	mta09-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S964891AbVHIRJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 13:09:46 -0400
Message-ID: <42F8E3E3.1010201@gentoo.org>
Date: Tue, 09 Aug 2005 18:12:03 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050723)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, mog.johnny@gmx.net
Subject: Re: irqpoll causing some breakage?
References: <42F7FD5E.6000107@gentoo.org> <1123605419.15600.35.camel@localhost.localdomain>
In-Reply-To: <1123605419.15600.35.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Without the parameters it has exactly zero effect on the operation of
> the kernel, the algorithms and the behaviour. So something odd is afoot
> if its causing gentoo breakages.

Thats what I thought, yet it seems to be the difference between mouse and no 
mouse in this case.

Strange. We'll try a different compiler.

Thanks.
Daniel
