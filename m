Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130507AbRDMM4i>; Fri, 13 Apr 2001 08:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130532AbRDMM42>; Fri, 13 Apr 2001 08:56:28 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:43276 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S130507AbRDMM4V>;
	Fri, 13 Apr 2001 08:56:21 -0400
Date: Fri, 13 Apr 2001 14:56:14 +0200
From: Jens Axboe <axboe@suse.de>
To: Ian Eure <ieure@insynq.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: loop problems continue in 2.4.3
Message-ID: <20010413145614.E13621@suse.de>
In-Reply-To: <15055.36597.353681.125824@pyramid.insynq.com> <20010409095607.A432@suse.de> <15060.43709.340915.563107@pyramid.insynq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15060.43709.340915.563107@pyramid.insynq.com>; from ieure@insynq.com on Wed, Apr 11, 2001 at 12:04:29PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11 2001, Ian Eure wrote:
> i get this message when it panics:
> 
> -- snip --
> loop: setting 534781920 bs for 07:86
> Kernel panic: Invalid blocksize passed to set_blocksize
> -- snip --

Ahm, how are you setting your loop device up? The above is completely
bogus.

-- 
Jens Axboe

