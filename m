Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261337AbUJZQ52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbUJZQ52 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 12:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbUJZQ52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 12:57:28 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35986 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261337AbUJZQ50
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 12:57:26 -0400
Message-ID: <417E81E4.4020309@pobox.com>
Date: Tue, 26 Oct 2004 12:57:08 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <juhl-lkml@dif.dk>
CC: Timothy Miller <miller@techsource.com>, pbecke <pbecke@javagear.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
References: <6.1.2.0.1.20041026082223.0231edd8@mail.javagear.com> <417E70D2.2010302@techsource.com> <Pine.LNX.4.61.0410261827430.3252@dragon.hygekrogen.localhost>
In-Reply-To: <Pine.LNX.4.61.0410261827430.3252@dragon.hygekrogen.localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> I'd say a card with open source drivers and access to detailed
> documentation from a company that's willing to work with the Open Source
> Software community is a very big first step, and a massive improvement on
> the current state of affairs. If we could just get that as a start, then I
> for one would be thrilled.


Well, as Alan mentioned, there are already five 3D chipsets out there 
with docs going to anyone who is serious about implementing a 3D driver 
for that particular piece of hardware.  You need more than just 
available docs and hardware.

You need...

* engineering resources to implement a complicated driver (3D h/w 
drivers are complex beasts)

* a compelling design and/or [low] cost

* to avoid the problem where the h/w changes so often, the open source 
driver maintainers simply cannot keep up.

	Jeff


