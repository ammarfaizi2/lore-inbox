Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261613AbULZFJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbULZFJR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 00:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbULZFJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 00:09:17 -0500
Received: from mx.inch.com ([216.223.198.27]:50194 "EHLO util.inch.com")
	by vger.kernel.org with ESMTP id S261613AbULZFJN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 00:09:13 -0500
Date: Sun, 26 Dec 2004 00:09:10 -0500 (EST)
From: John McGowan <jmcgowan@inch.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Intel 810(E) driver in Kernel 2.6.10 - same problem as in 2.6.9
In-Reply-To: <1104005852.23660.0.camel@localhost.localdomain>
Message-ID: <20041226000321.W98794@shell.inch.com>
References: <20041225193400.GA2700@localhost.localdomain>
 <1104005852.23660.0.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Dec 2004, Alan Cox wrote:

> On Sad, 2004-12-25 at 19:34, John McGowan wrote:
>> Intel 810(E) driver in Kernel 2.6.10 - same problem as in 2.6.9
>>
>> Fedora Core2; xorg 6.8.1 (and 6.7.x); kernel 2.6.9/2.6.10
>>               (other problem in earlier 2.6.x?)
>>               Intel i810(E) driver
>
> In my case at least updating the X server packages fixed it.
>

To which version? 6.8.1 (rpm build from Fedora Core xorg-6.8.1-12.src.rpm).
I see that 6.8.1 is the latest at xorg.

Fixed the memory or getting X to run at all on an 810?

Regards from:

     John McGowan  |  jmcgowan@inch.com                [Internet Channel]
                   |  jmcgowan@coin.org                [COIN]
     --------------+-----------------------------------------------------
