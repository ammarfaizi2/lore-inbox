Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264270AbTKTEvj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 23:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264271AbTKTEvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 23:51:39 -0500
Received: from mail-05.iinet.net.au ([203.59.3.37]:44211 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S264270AbTKTEvh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 23:51:37 -0500
Message-ID: <3FBC47C1.6040209@cyberone.com.au>
Date: Thu, 20 Nov 2003 15:49:05 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: William Lee Irwin III <wli@holomorphy.com>,
       Jeff Garzik <jgarzik@pobox.com>, jt@hpl.hp.com,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Pontus Fuchs <pof@users.sourceforge.net>
Subject: Re: Announce: ndiswrapper
References: <20031120031137.GA8465@bougret.hpl.hp.com>	<3FBC3483.4060706@pobox.com>	<20031120040034.GF19856@holomorphy.com>	<3FBC402E.6070109@cyberone.com.au> <16316.17526.900850.239502@notabene.cse.unsw.edu.au>
In-Reply-To: <16316.17526.900850.239502@notabene.cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Neil Brown wrote:

>On Thursday November 20, piggin@cyberone.com.au wrote:
>
>>You have to admit its good for end users though. And indirectly, what
>>is good for them is good for us. Take the nvidia example: end users get
>>either a binary driver or nothing. If we were somehow able to stop
>>nvidia from distributing their binary driver, they would say "OK".
>>
>
>Is it good for end users?  It allows them to buy a computer with an
>nvidia graphics controller because "NVidia supply drivers", and then
>discover that support is only as good as NVidia are willing to make
>it.  I'm still waiting for some sort of power management support for
>the nvidia controller in my notebook.  If the driver and the specs
>were open, I could possibly do it myself.  On the other hand if there
>were no NVidia drivers, I never would have made the (arguable) mistake
>of buying this notebook.
>

I'm all for open specs, but in reality that doesn't always happen.
(out of interest, are there any OS 3d drivers for any current cards?)

I know what you mean, but I would find nvidia more at fault for not
providing power management than no OS drivers.

>
>Ofcourse we cannot and should not stop people from providing the
>option of binary only drivers, but I'm not convinced that we should
>acknowlege that people who provide binary-only drivers are doing a
>useful service for anyone but themselves.
>

No I wouldn't say that, I meant the Linux Kernel is doing the end users
a favour by allowing binary modules.


