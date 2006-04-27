Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965124AbWD0MoW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965124AbWD0MoW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 08:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965128AbWD0MoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 08:44:22 -0400
Received: from taurus.voltaire.com ([193.47.165.240]:32991 "EHLO
	taurus.voltaire.com") by vger.kernel.org with ESMTP id S965124AbWD0MoW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 08:44:22 -0400
Message-ID: <4450BC9C.6080409@voltaire.com>
Date: Thu, 27 Apr 2006 15:44:12 +0300
From: Or Gerlitz <ogerlitz@voltaire.com>
User-Agent: Thunderbird 1.4.1 (Windows/20051006)
MIME-Version: 1.0
To: Or Gerlitz <ogerlitz@voltaire.com>, rdreier@cisco.com,
       openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] iSER's Makefile and Kconfig
References: <Pine.LNX.4.44.0604271528140.16463-100000@zuben> <Pine.LNX.4.44.0604271530141.16463-100000@zuben> <20060427124001.GZ25520@lug-owl.de>
In-Reply-To: <20060427124001.GZ25520@lug-owl.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Apr 2006 12:44:19.0629 (UTC) FILETIME=[4D4C4DD0:01C669F8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan-Benedict Glaw wrote:
> Please always send patches in an order so that the kernel still is
> compilable.
> 
> Eg. with your first patch introducing the Makefile stuff (while the C
> files are still not there), this will break and thus make it harder to
> automatically trace down unrelated breakages.

OK, i understand it,

thanks,

Or.


