Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310979AbSD1PFb>; Sun, 28 Apr 2002 11:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311025AbSD1PFa>; Sun, 28 Apr 2002 11:05:30 -0400
Received: from [195.63.194.11] ([195.63.194.11]:23301 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S310979AbSD1PFa>; Sun, 28 Apr 2002 11:05:30 -0400
Message-ID: <3CCC0111.3050207@evision-ventures.com>
Date: Sun, 28 Apr 2002 16:02:57 +0200
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


Fine. However one has to hit the default configuration files
as well.

