Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261929AbSJIR4l>; Wed, 9 Oct 2002 13:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261866AbSJIRzu>; Wed, 9 Oct 2002 13:55:50 -0400
Received: from fep01-mail.bloor.is.net.cable.rogers.com ([66.185.86.71]:64677
	"EHLO fep01-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id <S261855AbSJIRzo>; Wed, 9 Oct 2002 13:55:44 -0400
Message-ID: <3DA46EFF.6000207@rogers.com>
Date: Wed, 09 Oct 2002 14:01:35 -0400
From: Jeff Muizlelaar <muizelaar@rogers.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [bk/patch] driver model update: device_unregister()
References: <Pine.LNX.4.44.0210091038540.7355-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at fep01-mail.bloor.is.net.cable.rogers.com from [24.43.126.4] using ID <muizelaar@rogers.com> at Wed, 9 Oct 2002 14:00:55 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>
>I do know that "kfs" is too much of a random collection of consonants.  
>Looks like something out of an IBM architecture manual. "kernelfs" is more
>acceptable, I think, but it's not perfect either - it's a bit too generic.  
>Isn't /proc a kernelfs too? But I can't come up with anything better..
>  
>
Maybe sysfs?
Though that might be too close to /proc/sys

-Jeff

