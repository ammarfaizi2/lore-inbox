Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316530AbSE0J0P>; Mon, 27 May 2002 05:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316516AbSE0J0O>; Mon, 27 May 2002 05:26:14 -0400
Received: from [195.63.194.11] ([195.63.194.11]:22546 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316531AbSE0J0M>; Mon, 27 May 2002 05:26:12 -0400
Message-ID: <3CF1ECD4.8080001@evision-ventures.com>
Date: Mon, 27 May 2002 10:22:44 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Trivial: move PCI ID definitions from ide-pci.c to pci_ids.h
In-Reply-To: <20020526152204.A18812@ucw.cz> <3CF1E7C0.9090909@evision-ventures.com> <20020527112039.R16102@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Dave Jones napisa?:
> On Mon, May 27, 2002 at 10:01:04AM +0200, Martin Dalecki wrote:
>  > Please note that pci_ids.h. is a generated file.
> 
> No. You're thinking of drivers/pci/devlist.h and classlist.h
> If you looks at pci_ids.h, you'll notice we only have IDs in there
> for devices Linux actually supports.

I stand corrected indeed. OK time for the next cup of coffe this
morning to get me awake finally :-).

