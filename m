Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313225AbSDDQPw>; Thu, 4 Apr 2002 11:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313226AbSDDQPn>; Thu, 4 Apr 2002 11:15:43 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:57099 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S313225AbSDDQPd>; Thu, 4 Apr 2002 11:15:33 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 4 Apr 2002 16:36:10 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Stelian Pop <stelian.pop@fr.alcove.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.8-pre1] motioneye video driver
Message-ID: <20020404163610.A6146@bytesex.org>
In-Reply-To: <20020404140305.GH9820@come.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2002 at 04:03:05PM +0200, Stelian Pop wrote:
> In 2.5.8-pre1 'video_generic_ioctl' has gone, replaced by 
> 'video_generic_ioctl'. However, no video driver has been
> updated to use the new API.
> 
> The Gerd's patches from http://bytesex.org/patches/2.5/
> must be applied.

Whoops.  BK did a great job with merging -pre1 into my tree.  I havn't
even noticed this.

Someone must have picked my lkml mail with the videodev changes and
feed it to Linus.  No problem, I had planed to submit it anyway.  Going
to mail the driver fixes to Linus now ...

  Gerd

-- 
#include </dev/tty>
