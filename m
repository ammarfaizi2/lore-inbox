Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264226AbTKTEQw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 23:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264255AbTKTEQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 23:16:52 -0500
Received: from mail-05.iinet.net.au ([203.59.3.37]:968 "HELO mail.iinet.net.au")
	by vger.kernel.org with SMTP id S264226AbTKTEQu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 23:16:50 -0500
Message-ID: <3FBC402E.6070109@cyberone.com.au>
Date: Thu, 20 Nov 2003 15:16:46 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Jeff Garzik <jgarzik@pobox.com>, jt@hpl.hp.com,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Pontus Fuchs <pof@users.sourceforge.net>
Subject: Re: Announce: ndiswrapper
References: <20031120031137.GA8465@bougret.hpl.hp.com> <3FBC3483.4060706@pobox.com> <20031120040034.GF19856@holomorphy.com>
In-Reply-To: <20031120040034.GF19856@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



William Lee Irwin III wrote:

>Jean Tourrilhes wrote:
>
>>>	Even better :
>>>		1) go to the Wireless LAN Howto
>>>		2) find a card are supported under Linux that suit your needs
>>>		3) buy this card
>>>	I don't see the point of giving our money to vendors that
>>>don't care about us when there are vendors making a real effort toward
>>>us.
>>>
>
>On Wed, Nov 19, 2003 at 10:26:59PM -0500, Jeff Garzik wrote:
>
>>Unfortunately that leaves users without support for any recent wireless 
>>hardware.  It gets more and more difficult to even find Linux-supported 
>>wireless at Fry's and other retail locations...
>>
>
>And what good would it be to have an entire driver subsystem populated
>by binary-only drivers? That's not part of Linux, that's "welcome to
>nvidia hell" for that subsystem too, and not just graphics cards.
>
>I say we should go the precise opposite direction and take a hard line
>stance against binary drivers, lest we find there are none left we even
>have source to and are bombarded with unfixable bugreports.
>
>No, it's not my call to make, but basically, I don't see many benefits
>left. The additional drivers we got out of this were highly version-
>dependent, extremely fragile, and have been generating massive numbers
>of bugreports nonstop on a daily basis since their inception.
>
>We'd lose a few things, like vmware, but it's not worth the threat of
>vendors migrating en masse to NDIS/etc. emulation layers and dropping
>all spec publication and source drivers, leaving us entirely at the
>mercy of BBB's (Buggy Binary Blobs) to do any io whatsoever.
>
>Seriously, the binary-only business has been doing us a disservice, and
>is threatening to do worse.
>

You have to admit its good for end users though. And indirectly, what
is good for them is good for us. Take the nvidia example: end users get
either a binary driver or nothing. If we were somehow able to stop
nvidia from distributing their binary driver, they would say "OK".

I don't advocate making it easy to do non native drivers of course.


