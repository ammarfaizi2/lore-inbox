Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265283AbRFUXLn>; Thu, 21 Jun 2001 19:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265285AbRFUXLd>; Thu, 21 Jun 2001 19:11:33 -0400
Received: from ip-64-63-65-105.reverse.mobilenetics.com ([64.63.65.105]:5868
	"HELO homa.asicdesigners.com") by vger.kernel.org with SMTP
	id <S265284AbRFUXL2>; Thu, 21 Jun 2001 19:11:28 -0400
Date: Thu, 21 Jun 2001 16:09:50 -0700
From: Mike Mackovitch <macko@asicdesigners.com>
To: "David S. Miller" <davem@redhat.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, root@chaos.analogic.com,
        linux-kernel@vger.kernel.org
Subject: Re: Is it useful to support user level drivers
Message-ID: <20010621160949.A10977@wacko.asicdesigners.com>
In-Reply-To: <mailman.993156181.18994.linux-kernel2news@redhat.com> <200106212206.f5LM6dK12282@devserv.devel.redhat.com> <15154.29468.215080.602628@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <15154.29468.215080.602628@pizda.ninka.net>; from davem@redhat.com on Thu, Jun 21, 2001 at 03:20:12PM -0700
X-OriginalArrivalTime: 21 Jun 2001 23:11:03.0593 (UTC) FILETIME=[716E9990:01C0FAA7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2001 at 03:20:12PM -0700, David S. Miller wrote:
> 
> Pete Zaitcev writes:
>  > If memory does not deceive me, SunLab Spring processed interrupts
>  > in user space. I do not remember for sure, but I think QNX did, too.
>  > User mode interrupt handlers are perfectly doable, provided that the
>  > hardware allows to mask interrupts selectively.
> 
> SGI's IRIX does it too, for graphics card interrupts like "VBLANK" and
> "rendering pipeline FIFO not full anymore".

Sorry, but SGI's IRIX does NOT handle graphics interrupts in user space.

--macko
SGI Graphics Kernel Engineer 1994-1999
