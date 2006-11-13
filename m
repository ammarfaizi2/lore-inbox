Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754788AbWKMOqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754788AbWKMOqg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 09:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754790AbWKMOqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 09:46:36 -0500
Received: from rtr.ca ([64.26.128.89]:9743 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1754788AbWKMOqg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 09:46:36 -0500
Message-ID: <4558854A.2080902@rtr.ca>
Date: Mon, 13 Nov 2006 09:46:34 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
Cc: Stephen.Clark@seclark.us, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: What processor type?
References: <4557534E.9040205@seclark.us> <1163363865.15249.32.camel@laptopd505.fenrus.org>
In-Reply-To: <1163363865.15249.32.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Sun, 2006-11-12 at 12:01 -0500, Stephen Clark wrote:
>> Hello List,
>>
>> Could someone tell me what processor type I should select during kernel 
>> config for
>> an Intel Core 2 Duo T5600 chip.
> 
> the x86-64 "generic" option works best:

For 32-bit kernels, I suppose it should be one of Pentium-M or Pentium-4.


