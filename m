Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261178AbVCOLwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbVCOLwp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 06:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbVCOLwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 06:52:45 -0500
Received: from [195.144.244.147] ([195.144.244.147]:42401 "EHLO
	amanaus.varma-el.com") by vger.kernel.org with ESMTP
	id S261178AbVCOLwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 06:52:43 -0500
Message-ID: <4236CC87.5030401@varma-el.com>
Date: Tue, 15 Mar 2005 14:52:39 +0300
From: Andrey Volkov <avolkov@varma-el.com>
Organization: Varma Electronics Oy
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benedikt Spranger <b.spranger@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: CANbus subsytem for 2.6 kernel (char or netdev)
References: <4236B1D1.7030707@varma-el.com> <1110884699.5812.10.camel@atlas.tec.linutronix.de>
In-Reply-To: <1110884699.5812.10.camel@atlas.tec.linutronix.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benedikt,

Yes, thanks, very close to what about I thinking :),
but are you measure overhead of netdev (it disturb me)?

Andrey

Benedikt Spranger wrote:
>>Anyone could told me, why everyone, who wrote CANbus driver (peak, 
>>kvaser etc) always use char dev, but not netdev for it? May be exist 
>>some global pitfall, which I couldn't see, which prevent to use netdev?
> 
> 
> Maybe you try out:
> http://www.linutronix.de/data/linux-2.6.11-can.diff
> 
> Bene
> 
