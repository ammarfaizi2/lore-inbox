Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265270AbTLaW1o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 17:27:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265273AbTLaW1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 17:27:44 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:57124 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S265270AbTLaW1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 17:27:42 -0500
Message-ID: <3FF34B09.9040302@myrealbox.com>
Date: Wed, 31 Dec 2003 14:17:45 -0800
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20031231
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: udev and devfs - The final word
References: <fa.af64864.ugabhg@ifi.uio.no> <fa.de7jae9.1jk0pjt@ifi.uio.no>
In-Reply-To: <fa.de7jae9.1jk0pjt@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

> In fact, now that I know Gentoo works without devfs, I'm considering
> putting it on an old laptop I have around here...

That would be ideal.  I'm sure you will like the 'portage' system as
much as we (the gentoo hordes) do.

Note that the portage system already includes 'hotplug' and 'udev'
but possibly lagging behind a bit:  hotplug-20030805-r3 and udev-011.

I have installed them both but just have not been able to get udev
working yet -- I don't yet understand the problems well enough to tell
you why, unfortutately.  (udev is still marked 'experimental' so I'm
probably omitting important steps somewhere.)

If you could get udev working in gentoo you would become an instant
hero rather than the target of nasty emails.  Think of how great
that would be for your New Year!  We would become the wind beneath
your wings instead of the rotten tomatoes in your mailbox  ;0)
