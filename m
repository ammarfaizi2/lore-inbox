Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261988AbTCLUnt>; Wed, 12 Mar 2003 15:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261990AbTCLUnt>; Wed, 12 Mar 2003 15:43:49 -0500
Received: from [80.190.48.67] ([80.190.48.67]:64516 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id <S261988AbTCLUnr> convert rfc822-to-8bit; Wed, 12 Mar 2003 15:43:47 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Rik van Riel <riel@surriel.com>, linux-mm@kvack.org
Subject: Re: [PATCH] rmap 15e
Date: Wed, 12 Mar 2003 21:53:54 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0303121516270.3890-100000@dhcp64-226.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0303121516270.3890-100000@dhcp64-226.boston.redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200303122153.28046.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 March 2003 21:19, Rik van Riel wrote:

Hi Rik,

> After a change to a new house, in a new city, in a new country
> and with a new job I finally have time for -rmap development again.
> Curious what happened to me?  http://surriel.com/nh.shtml ;)
I hope you are feeling very well at your new house/city/job :)

> rmap 15e:
>   - make reclaiming unused inodes more efficient       (Arjan van de Ven)
>     | push to Marcelo and Andrew once it's well tested !
>   - fix DRM memory leak                                (Arjan van de Ven)
>   - fix potential infinite loop in kswapd                 (me)
>   - clean up elevator.h (no IO scheduler in -rmap...)     (me)
>   - page aging interval tuned on a per zone basis, better
>     wakeup mechanism for sudden memory pressure           (Arjan, me)
Great to see this!! Many thanks. I've merged this for WOLK v4.0s-rc4 upcoming 
within the next days.

ciao, Marc
