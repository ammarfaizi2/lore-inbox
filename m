Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310769AbSD1OiY>; Sun, 28 Apr 2002 10:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310835AbSD1OiX>; Sun, 28 Apr 2002 10:38:23 -0400
Received: from [195.63.194.11] ([195.63.194.11]:14597 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S310769AbSD1OiW>; Sun, 28 Apr 2002 10:38:22 -0400
Message-ID: <3CCBFAB6.7060607@evision-ventures.com>
Date: Sun, 28 Apr 2002 15:35:50 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: [bk+patch] Let (WIP) be replaced with (EXPERIMENTAL)
In-Reply-To: <20020428142415.A10747@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Vojtech Pavlik napisa?:
> ChangeSet@1.571, 2002-04-28 14:22:33+02:00, vojtech@twilight.ucw.cz
>   This removes the CONFIG_IDEDMA_PCI_WIP option, replacing it with
>   the more common CONFIG_EXPERIMENTAL. It also adds a depencency
>   on $CONFIG_EXPERIMENTAL where missing.


All fine and all will be taken. However please note that
I don't use BK and I don't intend too. My rejection of
it isn't based on any idiotic policy - I found it just ugly to
use and I was confused about the beta-alpha versions
offered on the web site - too much work in progress for my taste.
Finally I don't entrust source code to programmers who even don't know
the difference between TCP and UDP and use TCP becouse they don't know better.
I preferr a classical diff -urN ;-).


