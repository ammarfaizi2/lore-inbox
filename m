Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271345AbRHPMyK>; Thu, 16 Aug 2001 08:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271566AbRHPMyB>; Thu, 16 Aug 2001 08:54:01 -0400
Received: from fe170.worldonline.dk ([212.54.64.199]:46088 "HELO
	fe170.worldonline.dk") by vger.kernel.org with SMTP
	id <S271345AbRHPMxw>; Thu, 16 Aug 2001 08:53:52 -0400
Date: Thu, 16 Aug 2001 14:56:36 +0200
From: Jens Axboe <axboe@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: [patch] zero-bounce highmem I/O
Message-ID: <20010816145636.B4352@suse.de>
In-Reply-To: <20010816135150.X4352@suse.de> <20010816.045642.116348743.davem@redhat.com> <20010816140317.Y4352@suse.de> <20010816.052727.68039859.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010816.052727.68039859.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16 2001, David S. Miller wrote:
> Enough babbling on my part, I'll have a look at your bounce patch
> later today. :-)

Wait for the next version, I'll clean up the PCI DMA bounce value stuff
first and post a new version.

-- 
Jens Axboe

