Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262743AbVCDCyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262743AbVCDCyW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 21:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262757AbVCDCst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 21:48:49 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:47063 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262743AbVCCXmM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 18:42:12 -0500
Subject: Re: RFD: Kernel release numbering
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, Andrew Morton <akpm@osdl.org>,
       Dave Jones <davej@redhat.com>, davem@davemloft.net, jgarzik@pobox.com,
       torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050303031047.GA30423@infradead.org>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
	 <42264F6C.8030508@pobox.com> <20050302162312.06e22e70.akpm@osdl.org>
	 <42265A6F.8030609@pobox.com> <20050302165830.0a74b85c.davem@davemloft.net>
	 <20050303011151.GJ10124@redhat.com> <20050302172049.72a0037f.akpm@osdl.org>
	 <16934.28536.137910.735002@cse.unsw.edu.au>
	 <20050303031047.GA30423@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1109893184.21781.62.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 03 Mar 2005 23:39:45 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-03-03 at 03:10, Christoph Hellwig wrote:
> The point is that it's happening anyway.  See Andres' -as tree which
> is the basis for the Debian vendor kernel.  Getting that up to an
> official status as 2.6.x.y would be very nice (and having it on
> linux.bkbits.net)

IMHO it is nowhere near conservative enough (or at times complete
enough) to be a 2.6.x.y kernel. In some respects -ac is closer but it
also isn't as conservative as a real 2.6.x.y should be.

2.6.x.y needs several people to keep it tight and to ensure there is
always cover on a security fix. 
