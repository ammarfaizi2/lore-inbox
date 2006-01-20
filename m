Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751053AbWATTBc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbWATTBc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 14:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbWATTBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 14:01:32 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:54723 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750941AbWATTBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 14:01:32 -0500
Date: Fri, 20 Jan 2006 13:00:59 -0600
From: Jack Steiner <steiner@sgi.com>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Brent Casavant <bcasavan@sgi.com>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, jes@sgi.com, tony.luck@intel.com
Subject: Re: [PATCH] SN2 user-MMIO CPU migration
Message-ID: <20060120190059.GB6788@sgi.com>
References: <20060118163305.Y42462@chenjesu.americas.sgi.com> <200601191818.43157.jbarnes@virtuousgeek.org> <20060120132650.GA4272@sgi.com> <200601200931.58281.jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601200931.58281.jbarnes@virtuousgeek.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > A second reason for an arch_task_migrate() instead of a specific
> > mmiob() is to provide a hook for a future platform that require
> > additional work to be done when a task migrates.
> 
> What does the new platform require (just curious)?
> 
> Jesse

Sorry, can't say. Rejoin SGI & I'll tell you :-)

---
Jack 


