Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266289AbUHGGcU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266289AbUHGGcU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 02:32:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267776AbUHGGcU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 02:32:20 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:46767 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S266289AbUHGGcS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 02:32:18 -0400
Date: Fri, 6 Aug 2004 23:30:01 -0700
From: Paul Jackson <pj@sgi.com>
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: mbligh@aracnet.com, efocht@hpce.nec.com, lse-tech@lists.sourceforge.net,
       akpm@osdl.org, hch@infradead.org, steiner@sgi.com, jbarnes@sgi.com,
       sylvain.jeaugey@bull.net, djh@sgi.com, linux-kernel@vger.kernel.org,
       colpatch@us.ibm.com, Simon.Derr@bull.net, ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-Id: <20040806233001.4218ca0c.pj@sgi.com>
In-Reply-To: <4113A860.4070007@watson.ibm.com>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	<20040805190500.3c8fb361.pj@sgi.com>
	<247790000.1091762644@[10.10.2.4]>
	<200408061730.06175.efocht@hpce.nec.com>
	<267050000.1091806507@[10.10.2.4]>
	<4113A860.4070007@watson.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubertus wrote:
> As indicated above, this would mean to create a resource controller
> and assign mask to them, which is not what we have done so far, as
> our current controllers are more share focused.

Could you explain this a bit?  In particular, the phrases
"assign mask" and "share focused" went wizzing right on
past me.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
