Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288855AbSA0W1j>; Sun, 27 Jan 2002 17:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288882AbSA0W11>; Sun, 27 Jan 2002 17:27:27 -0500
Received: from mx04.nexgo.de ([151.189.8.80]:5901 "EHLO mx04.nexgo.de")
	by vger.kernel.org with ESMTP id <S288855AbSA0W1R>;
	Sun, 27 Jan 2002 17:27:17 -0500
Message-ID: <3C547EB8.5010604@arcor.de>
Date: Sun, 27 Jan 2002 23:27:04 +0100
From: Hartmut Holz <hartmut.holz@arcor.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020116
X-Accept-Language: en-us
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Uptime again?
In-Reply-To: <Pine.LNX.4.33L.0201261935330.32617-100000@imladris.surriel.com> <3C54546C.0@arcor.de> <002801c1a76b$623033f0$010411ac@local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:

> What do you means with one cpu? Did you boot a SMP kernel with "nosmp" on the command line, or did you make a kernel without
> CONFIG_SMP?
> 

from .config:
-------------

CONFIG_MTRR=y
# CONFIG_SMP is not set
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y

Of cause it was a new clean kernel tree. Tomorrow I will use your patch for this tree.
May be there are some results in the log.

Regards

Hartmut

