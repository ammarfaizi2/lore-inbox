Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263794AbSJOTlH>; Tue, 15 Oct 2002 15:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264653AbSJOTlH>; Tue, 15 Oct 2002 15:41:07 -0400
Received: from gate.perex.cz ([194.212.165.105]:9223 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S263794AbSJOTlH>;
	Tue, 15 Oct 2002 15:41:07 -0400
Date: Tue, 15 Oct 2002 21:45:56 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: "David S. Miller" <davem@redhat.com>
cc: "torvalds@transmeta.com" <torvalds@transmeta.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: ALSA update
In-Reply-To: <20021015.100811.118915540.davem@redhat.com>
Message-ID: <Pine.LNX.4.33.0210152145240.703-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Oct 2002, David S. Miller wrote:

>    From: Jaroslav Kysela <perex@perex.cz>
>    Date: Tue, 15 Oct 2002 00:43:53 +0200 (CEST)
> 
>    Oops. Missing two backslashes. It should be corrected with this patch 
>    (already in linux-sound BK repository):
> 
> That's just the tip of the iceberg.
> 
> It fails again soon after that, none of the ioctl32.c/pcm32.c
> changes were even _compile_ tested.

Thanks. Applied to linux-sound repository.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com

