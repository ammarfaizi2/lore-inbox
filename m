Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313078AbSDYRjI>; Thu, 25 Apr 2002 13:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313242AbSDYRjH>; Thu, 25 Apr 2002 13:39:07 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:13330 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S313078AbSDYRjG>;
	Thu, 25 Apr 2002 13:39:06 -0400
Date: Thu, 25 Apr 2002 19:39:08 +0200
From: Jens Axboe <axboe@suse.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.10 IDE 41
Message-ID: <20020425173908.GN3542@suse.de>
In-Reply-To: <Pine.LNX.4.33.0203181243210.10517-100000@penguin.transmeta.com> <3CC8136B.2060705@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25 2002, Martin Dalecki wrote:
> Tue Apr 23 00:27:55 CEST 2002 ide-clean-41
> 
> - Revoke the TCQ stuff. Well having it for some time showed just nicely what
>   has to be done before it can be included cleanly. But it's just not ready
>   jet.

Again, you charge ahead instead of just getting it fixed... It's not a
lot of work!

If you want to disable the TCQ stuff until this is fixed, fine, I have
no objection to that. Completely ripping it out is a silly decision.
First you blast ahead and include even before I ask you or sent it to
Linus myself, now you remove it without my consent as well. A bit of
consistency would get you a long way.

-- 
Jens Axboe

