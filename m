Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262858AbVAFPQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262858AbVAFPQz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 10:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262865AbVAFPQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 10:16:53 -0500
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:20408 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S262858AbVAFPQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 10:16:21 -0500
Date: Thu, 6 Jan 2005 10:16:16 -0500
To: Andriy Korud <a.korud@vector.com.pl>
Cc: "Luis R. Rodriguez" <mcgrof@ruslug.rutgers.edu>,
       Steve Hill <steve@nexusuk.org>, Netdev <netdev@oss.sgi.com>,
       Jean Tourrilhes <jt@bougret.hpl.hp.com>,
       "Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>,
       Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       prism54-users@prism54.org, prism54-devel@prism54.org
Subject: Re: [Prism54-devel] Re: [Prism54-users] Open hardware wireless cards
Message-ID: <20050106151616.GC30311@csclub.uwaterloo.ca>
References: <60E856FD577CC04BA3727AF4122D3F161134B8@3bit.vector.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60E856FD577CC04BA3727AF4122D3F161134B8@3bit.vector.com.pl>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2005 at 11:34:02PM +0100, Andriy Korud wrote:
> Sorry, as I know (no more details - NDA, sorry) some manufacturers are developing (and planning to continue) FullMAC 802.11g (and further) chipsets and also they are offering Linux drivers (however had no chance to test yet).
> 
> But from my point of view, SoftMAC cards are better sometimes - you have more control from drivers and can implement some interesting features (for example, madwifi Linux driver with MAC layer ported from xBSD). 
> 
> Any thoughts why we should prefer FullMAC cards over SoftMAC (except CPU usage, of course)?

Embedded systems with low end cpus (to make less heat and use less
power) would prefer anything that uses less cpu and can be done in
dedicated (and usually simpler than the cpu) hardware.  Of course the
windows laptop and desktop market probably far outsells the embedded
market, for now at least.

Len Sorensen
