Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265302AbRFUXwQ>; Thu, 21 Jun 2001 19:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265303AbRFUXwG>; Thu, 21 Jun 2001 19:52:06 -0400
Received: from ip-64-63-65-105.reverse.mobilenetics.com ([64.63.65.105]:56045
	"HELO homa.asicdesigners.com") by vger.kernel.org with SMTP
	id <S265302AbRFUXv4>; Thu, 21 Jun 2001 19:51:56 -0400
Date: Thu, 21 Jun 2001 16:50:15 -0700
From: Mike Mackovitch <macko@asicdesigners.com>
To: "David S. Miller" <davem@redhat.com>
Cc: Mike Mackovitch <macko@asicdesigners.com>,
        Pete Zaitcev <zaitcev@redhat.com>, root@chaos.analogic.com,
        linux-kernel@vger.kernel.org
Subject: Re: Is it useful to support user level drivers
Message-ID: <20010621165015.A11197@wacko.asicdesigners.com>
In-Reply-To: <mailman.993156181.18994.linux-kernel2news@redhat.com> <200106212206.f5LM6dK12282@devserv.devel.redhat.com> <15154.29468.215080.602628@pizda.ninka.net> <20010621160949.A10977@wacko.asicdesigners.com> <15154.33208.744328.463419@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <15154.33208.744328.463419@pizda.ninka.net>; from davem@redhat.com on Thu, Jun 21, 2001 at 04:22:32PM -0700
X-OriginalArrivalTime: 21 Jun 2001 23:51:28.0390 (UTC) FILETIME=[16B94260:01C0FAAD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2001 at 04:22:32PM -0700, David S. Miller wrote:
> 
> Mike Mackovitch writes:
>  > Sorry, but SGI's IRIX does NOT handle graphics interrupts in user space.
> 
> What the heck is ULI then?  I've actually read the assembly code for
> this back when I did my SGI internship.

If my memory serves me correctly, I believe ULI was some
hacked up "user-level interrupt" feature.  I have no idea
who (if anyone) used it, but it definitely wasn't used by
SGI's graphics drivers.

--macko
