Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932345AbVK2SuL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbVK2SuL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 13:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbVK2SuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 13:50:11 -0500
Received: from [85.8.13.51] ([85.8.13.51]:42661 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S932345AbVK2SuJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 13:50:09 -0500
Message-ID: <438CA2D9.8030304@drzeus.cx>
Date: Tue, 29 Nov 2005 19:50:01 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.7-2.1.fc4.nr (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, ambx1@neo.rr.com,
       Takashi Iwai <tiwai@suse.de>
Subject: Re: [Fwd: [PATCH] [PNP][RFC] Suspend support for PNP bus.]
References: <436B2819.4090909@drzeus.cx> <20051129113210.3d95d71f.akpm@osdl.org>
In-Reply-To: <20051129113210.3d95d71f.akpm@osdl.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Pierre Ossman <drzeus-list@drzeus.cx> wrote:
>  
>
>>Add support for suspending devices connected to the PNP bus. New
>>callbacks are added for the drivers and the PNP hardware layer is
>>told to disable the device during the suspend.
>>    
>>
>
>The ALSA guys have gone off and implemented their own version of this, and
>it's a bit different.   I'll need to drop this patch now.
>
>Please review http://www.zip.com.au/~akpm/linux/patches/stuff/git-alsa.patch, sort
>things out?
>  
>

That things is huge! Do the ALSA guys perhaps have a patch with just the
PnP bit in it?

Rgds
Pierre

