Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbTIYQX4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 12:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbTIYQX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 12:23:56 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:38600 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261328AbTIYQXz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 12:23:55 -0400
Message-Id: <200309251622.h8PGMaD1013425@death.ibm.com>
To: shmulik.hen@intel.com
cc: bonding-devel@lists.sourceforge.net,
       bonding-announce@lists.sourceforge.net, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       "Jeff Garzik" <jgarzik@pobox.com>, "Noam, Amir" <amir.noam@intel.com>,
       "Mendelson, Tsippy" <tsippy.mendelson@intel.com>,
       "Noam, Marom" <noam.marom@intel.com>
Subject: Re: [PATCH SET][bonding] cleanup 
In-Reply-To: Message from Shmulik Hen <shmulik.hen@intel.com> 
   of "Thu, 25 Sep 2003 15:49:59 +0300." <200309251549.59177.shmulik.hen@intel.com> 
Date: Thu, 25 Sep 2003 09:22:36 -0700
From: Jay Vosburgh <fubar@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>patch 7 - eliminate the multicast_mode module param. settings are now 
>          done only according to mode.

	This goes a bit beyond straight cleanup; could you explain the
rationale for this change?  Also, unless I'm missing something, the
patch does not appear to update bonding.txt to reflect the fact that
the module parameter is no more.

	-J

---
	-Jay Vosburgh, IBM Linux Technology Center, fubar@us.ibm.com
