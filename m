Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261373AbTCTQpZ>; Thu, 20 Mar 2003 11:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261357AbTCTQpZ>; Thu, 20 Mar 2003 11:45:25 -0500
Received: from havoc.daloft.com ([64.213.145.173]:43474 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S261352AbTCTQpX>;
	Thu, 20 Mar 2003 11:45:23 -0500
Date: Thu, 20 Mar 2003 11:56:18 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Shmulik Hen <hshmulik@intel.com>
Cc: Bonding Developement list <bonding-devel@lists.sourceforge.net>,
       Bonding Announce list <bonding-announce@lists.sourceforge.net>,
       Linux Net Mailing list <linux-net@vger.kernel.org>,
       Linux Kernel Mailing list <linux-kernel@vger.kernel.org>,
       Oss SGI Netdev list <netdev@oss.sgi.com>
Subject: Re: [patch] (0/8) Adding 802.3ad support to bonding
Message-ID: <20030320165618.GB8256@gtf.org>
References: <Pine.LNX.4.44.0303201553540.10351-100000@jrslxjul4.npdj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303201553540.10351-100000@jrslxjul4.npdj.intel.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I (and many others) will be going over these patches.  I also see that
somebody (davem?) applied your divide-by-zero patch to the mainline
kernel.

My initial comment is that we will want to work to eliminate these
ifdefs.  Other comments will follow.

Thanks to Intel for these efforts!

	Jeff




