Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262680AbVCCWcA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262680AbVCCWcA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 17:32:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262643AbVCCW2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 17:28:35 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:39127 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262680AbVCCW0c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 17:26:32 -0500
Subject: Re: RFD: Kernel release numbering
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, davem@davemloft.net, jgarzik@pobox.com,
       torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050303012707.GK10124@redhat.com>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
	 <42264F6C.8030508@pobox.com> <20050302162312.06e22e70.akpm@osdl.org>
	 <42265A6F.8030609@pobox.com> <20050302165830.0a74b85c.davem@davemloft.net>
	 <20050303011151.GJ10124@redhat.com> <20050302172049.72a0037f.akpm@osdl.org>
	 <20050303012707.GK10124@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1109888675.21781.59.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 03 Mar 2005 22:24:37 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-03-03 at 01:27, Dave Jones wrote:
> In an ideal world, we'd see a single 'y' release of 2.6.x.y, but if x+1 takes
> too long to be released, bits of x+1 should also appear in x.y+1
> The only question in my mind is 'how critical does a bug have to be to
> justify a .y release.  Once a new 'x' release comes out, the previous x.y
> would likely no longer get any further fixes (unless someone decides the
> new 'x' sucked so bad).

Do the statistics on rate of discovery of security problems (generally
low priority and by good guys/verification tools) and you are looking at
about x.y.8 or so assuming there are no 2.x.y.z releases for post
release howlers.

