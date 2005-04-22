Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262151AbVDVVTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262151AbVDVVTl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 17:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262140AbVDVVTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 17:19:14 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:43761 "EHLO
	dhcp153.mvista.com") by vger.kernel.org with ESMTP id S262138AbVDVVSC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 17:18:02 -0400
Date: Fri, 22 Apr 2005 14:17:54 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: Inaky Perez-Gonzalez <inaky@linux.intel.com>
cc: Ingo Molnar <mingo@elte.hu>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc3-V0.7.46-01
In-Reply-To: <17001.26444.246648.14231@sodium.jf.intel.com>
Message-ID: <Pine.LNX.4.44.0504221415420.4857-100000@dhcp153.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Oops, I missed that you tested a non-plist kernel .. Maybe there are some 
lingering problems in current stuff..

Daniel


On Fri, 22 Apr 2005, Inaky Perez-Gonzalez wrote:


> With 2.6.12-rc3-V0.7.46-02 I get:
> 
> ...
> 2 maximum cycle time: 0.003ms
> 3 maximum cycle time: 1.706ms
> 4 maximum cycle time: 1.538ms
> 5 maximum cycle time: 1.168ms
> 6 maximum cycle time: 0.003ms
> 7 maximum cycle time: 0.008ms
> 8 maximum cycle time: 1.821ms
> 9 maximum cycle time: 1.013ms
> 10 maximum cycle time: 1.043ms
> 11 maximum cycle time: 1.787ms
> 12 maximum cycle time: 1.519ms
> 13 ...
> 


