Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313257AbSC1Uet>; Thu, 28 Mar 2002 15:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313256AbSC1Uei>; Thu, 28 Mar 2002 15:34:38 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:45188 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S313255AbSC1Uea>;
	Thu, 28 Mar 2002 15:34:30 -0500
Date: Thu, 28 Mar 2002 21:34:13 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.7 IDE 26
Message-ID: <20020328213413.A28299@ucw.cz>
In-Reply-To: <Pine.LNX.4.33.0203181243210.10517-100000@penguin.transmeta.com> <3CA2E282.7070906@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2002 at 10:29:38AM +0100, Martin Dalecki wrote:
> Wed Mar 20 23:17:06 CET 2002 ide-clean-26
> 
> - Mark all members of structures, which get jiffies assigned or involved in
>    ugly timeout calculations with the prefix PADAM_  for easy spotting. This is
>    Polish for "I'm falling down" or "This brings me to the knees" or slag
>    comment for "What a sh..". Please be assured that it doesn't sound vulgar.

In Czech, too. :)

>    Please grep for it to see immediately why this nomenclature is justified.
> 
> - Rename hwifs_s to ata_channel and eliminate ide_hwifs_t as well as the HWIF
>    macro. OK this step makes this patch rather big.

-- 
Vojtech Pavlik
SuSE Labs
