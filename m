Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030209AbVHZTKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030209AbVHZTKw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 15:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030208AbVHZTKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 15:10:51 -0400
Received: from fmr24.intel.com ([143.183.121.16]:15240 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S1030205AbVHZTKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 15:10:50 -0400
Date: Fri, 26 Aug 2005 15:10:26 -0400
From: Benjamin LaHaise <bcrl@linux.intel.com>
To: Ben Greear <greearb@candelatech.com>
Cc: danial_thom@yahoo.com, Jesper Juhl <jesper.juhl@gmail.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: 2.6.12 Performance problems
Message-ID: <20050826191026.GA8023@linux.intel.com>
References: <20050825142647.70995.qmail@web33314.mail.mud.yahoo.com> <430DF7FF.9080502@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <430DF7FF.9080502@candelatech.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2005 at 09:55:27AM -0700, Ben Greear wrote:
> Of course.  Never found a motherboard yet with decent built-in
> NICs.  The built-ins on this board are tg3 and they must be on
> a slow bus, because they cannot go faster than about 700Mbps
> (using big pkts).

There should be a number of decent boards out on the market these days.  
Try picking up one with a CSA gige adapter (a dedicated high bandwidth 
link to an e1000) or PCI Express (although that is harder to pick up on 
from the specifications of most motherboards).

		-ben
