Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbVHWPFO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbVHWPFO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 11:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbVHWPFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 11:05:14 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:7933 "EHLO
	mta09-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932091AbVHWPFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 11:05:13 -0400
Message-ID: <430B3BA0.7040400@gentoo.org>
Date: Tue, 23 Aug 2005 16:07:12 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050820)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nigel Rantor <wiggly@wiggly.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: irq 11: nobody cared
References: <430B2419.7070109@wiggly.org>
In-Reply-To: <430B2419.7070109@wiggly.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Rantor wrote:
> Who should I be talking to wrt to the irq 11: nobody cared issue?
> 
> I'm happy to provide as much info as possible but need to know what info 
> is required.
> 
> I'm happily running 2.6.7, tried the latest and greatest (2.6.12) and 
> found the problem, then started by looking at 2.6.8 and found the 
> problem there too.

Try 2.6.13-rc6 and if it still appears, try the new "irqpoll" boot option.

Daniel
