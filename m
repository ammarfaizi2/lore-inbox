Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261320AbVCCBTp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbVCCBTp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 20:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261370AbVCCBPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 20:15:54 -0500
Received: from mx1.redhat.com ([66.187.233.31]:35287 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261351AbVCCBL7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 20:11:59 -0500
Date: Wed, 2 Mar 2005 20:11:51 -0500
From: Dave Jones <davej@redhat.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Jeff Garzik <jgarzik@pobox.com>, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050303011151.GJ10124@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jeff Garzik <jgarzik@pobox.com>, akpm@osdl.org, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <42264F6C.8030508@pobox.com> <20050302162312.06e22e70.akpm@osdl.org> <42265A6F.8030609@pobox.com> <20050302165830.0a74b85c.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050302165830.0a74b85c.davem@davemloft.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2005 at 04:58:30PM -0800, David S. Miller wrote:

 > The problem is people don't test until 2.6.whatever-final goes out.
 > Nothing will change that.
 > 
 > And the day Linus releases we always get a pile of "missing MODULE_EXPORT()"
 > type bug reports that are one liner fixes.  Those fixes will not be seen by
 > users until the next 2.6.x rev comes out and right now that takes months
 > which is rediculious for such simple fixes.

So what was broken with the 2.6.8.1 type of 'hotfix kernel' release ?
Apart from needing to do the 2.6.8.1 -> 2.6.8 -> 2.6.9 transition 
which confused some people, it seemed to be easily understood for what it was,
and solved the same problem as this new proposal.

		Dave

