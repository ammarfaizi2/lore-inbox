Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265262AbRFUWUf>; Thu, 21 Jun 2001 18:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265265AbRFUWUZ>; Thu, 21 Jun 2001 18:20:25 -0400
Received: from pizda.ninka.net ([216.101.162.242]:38795 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265262AbRFUWUP>;
	Thu, 21 Jun 2001 18:20:15 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15154.29468.215080.602628@pizda.ninka.net>
Date: Thu, 21 Jun 2001 15:20:12 -0700 (PDT)
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: root@chaos.analogic.com, linux-kernel@vger.kernel.org
Subject: Re: Is it useful to support user level drivers
In-Reply-To: <200106212206.f5LM6dK12282@devserv.devel.redhat.com>
In-Reply-To: <mailman.993156181.18994.linux-kernel2news@redhat.com>
	<200106212206.f5LM6dK12282@devserv.devel.redhat.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Pete Zaitcev writes:
 > If memory does not deceive me, SunLab Spring processed interrupts
 > in user space. I do not remember for sure, but I think QNX did, too.
 > User mode interrupt handlers are perfectly doable, provided that the
 > hardware allows to mask interrupts selectively.

SGI's IRIX does it too, for graphics card interrupts like "VBLANK" and
"rendering pipeline FIFO not full anymore".

Later,
David S. Miller
davem@redhat.com
