Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751564AbWB0XWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564AbWB0XWQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 18:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751523AbWB0XWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 18:22:16 -0500
Received: from 26.mail-out.ovh.net ([213.186.42.179]:32226 "EHLO
	26.mail-out.ovh.net") by vger.kernel.org with ESMTP
	id S1750719AbWB0XWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 18:22:14 -0500
Date: Tue, 28 Feb 2006 00:21:42 +0100
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: o_sync in vfat driver
Cc: "Anton Altaparmakov" <aia21@cam.ac.uk>,
       "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>,
       linux-kernel@vger.kernel.org
References: <op.s5cj47sxj68xd1@mail.piments.com> <op.s5jpqvwhui3qek@mail.piments.com> <op.s5kxhyzgfx0war@mail.piments.com> <op.s5kx7xhfj68xd1@mail.piments.com> <op.s5kya3t0j68xd1@mail.piments.com> <op.s5ky2dbcj68xd1@mail.piments.com> <op.s5ky71nwj68xd1@mail.piments.com> <op.s5kzao2jj68xd1@mail.piments.com> <op.s5lq2hllj68xd1@mail.piments.com> <20060227132848.GA27601@csclub.uwaterloo.ca> <1141048228.2992.106.camel@laptopd505.fenrus.org> <1141049176.18855.4.camel@imp.csi.cam.ac.uk> <1141050437.2992.111.camel@laptopd505.fenrus.org> <1141051305.18855.21.camel@imp.csi.cam.ac.uk> <op.s5ngtbpsj68xd1@mail.piments.com> <1141075047.2992.166.camel@laptopd505.fenrus.org>
From: col-pepper@piments.com
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <op.s5nm6gaoj68xd1@mail.piments.com>
In-Reply-To: <1141075047.2992.166.camel@laptopd505.fenrus.org>
User-Agent: Opera M2/8.52 (Linux, build 1631)
X-Ovh-Remote: 80.170.101.26 (d80-170-101-26.cust.tele2.fr)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-Spam-Check: fait|type 1&3|0.3|H 0.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Feb 2006 22:17:21 +0100, Arjan van de Ven <arjan@infradead.org>  
wrote:

>
>> Telling a user who has just burnt out a brand new 1GB usb device he  
>> should
>> have RTFM and modified that HAL configuration to insure it did not use
>> sync it not likely to win much confidence in the linux kernel.
>
> or in HAL. really.

It may unfairly reflect on HAL in the users' mind but hal still does  
exactly what it is set up to do.

>
>
> there was a very long discussion abuot kernel stability.
> The problem is that once depending on the absence of a feature becomes
> ABI ... there is a big problem.
>
>
>

It was not totally absent. If it was absent no-one would configure  
anything to use it anyway. It seems that big problem was that it  
functionality was fundamentlly changed but it was passed on like a minor  
mod that no-one needed to worry about and the doc was not updated at the  
time.
