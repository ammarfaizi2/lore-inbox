Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261462AbVCCDPf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbVCCDPf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 22:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbVCCDPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 22:15:17 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:55215 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261463AbVCCDLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 22:11:00 -0500
Date: Thu, 3 Mar 2005 03:10:48 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>,
       davem@davemloft.net, jgarzik@pobox.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050303031047.GA30423@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Neil Brown <neilb@cse.unsw.edu.au>, Andrew Morton <akpm@osdl.org>,
	Dave Jones <davej@redhat.com>, davem@davemloft.net,
	jgarzik@pobox.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <42264F6C.8030508@pobox.com> <20050302162312.06e22e70.akpm@osdl.org> <42265A6F.8030609@pobox.com> <20050302165830.0a74b85c.davem@davemloft.net> <20050303011151.GJ10124@redhat.com> <20050302172049.72a0037f.akpm@osdl.org> <16934.28536.137910.735002@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16934.28536.137910.735002@cse.unsw.edu.au>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2005 at 12:59:20PM +1100, Neil Brown wrote:
> I think there is a case for the "community" providing the most
> "stable" kernel that it (reasonably) can without depending on
> "distributions" to do that.

The point is that it's happening anyway.  See Andres' -as tree which
is the basis for the Debian vendor kernel.  Getting that up to an
official status as 2.6.x.y would be very nice (and having it on
linux.bkbits.net)

