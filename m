Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965281AbWFIP4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965281AbWFIP4Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 11:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030248AbWFIPz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 11:55:56 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:35816 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030246AbWFIPzx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 11:55:53 -0400
Message-ID: <44899A05.4070106@sgi.com>
Date: Fri, 09 Jun 2006 08:55:49 -0700
From: Chris Sturtivant <csturtiv@sgi.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: Shailabh Nagar <nagar@watson.ibm.com>
CC: Jay Lan <jlan@sgi.com>, Balbir Singh <balbir@in.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Patch][RFC]  Disabling per-tgid stats on task exit in taskstats
References: <44892610.6040001@watson.ibm.com>
In-Reply-To: <44892610.6040001@watson.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Shailabh Nagar wrote:
> Jay, Chris, Could you check if this patch does the needful ?
> Its tested and runs fine for me. A quick response would be appreciated 
> so that it can be included in -mm before the 2.6.18 merge window begins.
>
> I decided against adding the configuration to the taskstats interface 
> directly (as another command) since the sysfs solution
> is much simpler and the configuration operation is infrequent.
>
> Balbir, all, comments welcome.
>
> --Shailabh
>
>
Unfortunately, I'm currently battling some build problems, so hopefully 
Jay will be able to take a look through it today.

Best regards,


--Chris

-- 
-----------------------------------------------------------------
Chris Sturtivant, PhD,
Linux System Software,
SGI
(650) 933-1703
-----------------------------------------------------------------

