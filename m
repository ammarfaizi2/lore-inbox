Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283046AbRK1N7k>; Wed, 28 Nov 2001 08:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283056AbRK1N7e>; Wed, 28 Nov 2001 08:59:34 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:16655 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S283052AbRK1N7U>;
	Wed, 28 Nov 2001 08:59:20 -0500
Date: Wed, 28 Nov 2001 14:58:58 +0100
From: Jens Axboe <axboe@suse.de>
To: Sebastian =?iso-8859-1?Q?Dr=F6ge?= <sebastian.droege@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-pre2 compile error in ide-scsi.o ide-scsi.c
Message-ID: <20011128145858.A23858@suse.de>
In-Reply-To: <20011128135552.204311E532@Cantor.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20011128135552.204311E532@Cantor.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28 2001, Sebastian Dröge wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi Jens,
> your patch doesn't work for ide-scsi
> I get this oops when trying to mount a CD:

[oops in sr_scatter_pad]

Hmm ok, and 2.5.1-pre1 works for you right?

-- 
Jens Axboe

