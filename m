Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261383AbVCCCUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbVCCCUu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 21:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261393AbVCCCSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 21:18:53 -0500
Received: from fire.osdl.org ([65.172.181.4]:52633 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261383AbVCCCN1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 21:13:27 -0500
Date: Wed, 2 Mar 2005 18:13:15 -0800
From: Chris Wright <chrisw@osdl.org>
To: Dave Jones <davej@redhat.com>, "David S. Miller" <davem@davemloft.net>,
       Jeff Garzik <jgarzik@pobox.com>, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050303021315.GM28536@shell0.pdx.osdl.net>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <42264F6C.8030508@pobox.com> <20050302162312.06e22e70.akpm@osdl.org> <42265A6F.8030609@pobox.com> <20050302165830.0a74b85c.davem@davemloft.net> <20050303011151.GJ10124@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050303011151.GJ10124@redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Dave Jones (davej@redhat.com) wrote:
> So what was broken with the 2.6.8.1 type of 'hotfix kernel' release ?

I agree, I think that's useful and needed.  It's possible to get the
fixes committed to an effective branch in bk and pull that back into
mainline.  So at each new release the last release hotfix branch would
stop.  But does that solve a different problem?  I don't think it'll
increase people testing intended-stable versions.

thanks,
-chris
