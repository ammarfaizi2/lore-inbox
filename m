Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265754AbSJYAdR>; Thu, 24 Oct 2002 20:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265755AbSJYAdN>; Thu, 24 Oct 2002 20:33:13 -0400
Received: from sccrmhc03.attbi.com ([204.127.202.63]:41601 "EHLO
	sccrmhc03.attbi.com") by vger.kernel.org with ESMTP
	id <S265754AbSJYAdJ>; Thu, 24 Oct 2002 20:33:09 -0400
Date: Thu, 24 Oct 2002 17:39:18 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: "Leech, Christopher" <christopher.leech@intel.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: PCI device order problem
Message-ID: <20021024173918.A23457@lucon.org>
References: <BD9B60A108C4D511AAA10002A50708F2073175F8@orsmsx118.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <BD9B60A108C4D511AAA10002A50708F2073175F8@orsmsx118.jf.intel.com>; from christopher.leech@intel.com on Thu, Oct 24, 2002 at 05:25:01PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2002 at 05:25:01PM -0700, Leech, Christopher wrote:
> 
> If you're that concerned about possible ordering changes due to future BIOS
> upgrades, I'd suggest setting up an /etc/mactab and using nameif to control
> interface naming from userspace.
> 

That is not enough. I use PXE to install RedHat. The RedHat 7.3 installer only
deals with ethX.


H.J.
