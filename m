Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261557AbVAGVPL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261557AbVAGVPL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 16:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbVAGVOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 16:14:53 -0500
Received: from colin2.muc.de ([193.149.48.15]:10001 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261557AbVAGVMB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 16:12:01 -0500
Date: 7 Jan 2005 22:12:00 +0100
Date: Fri, 7 Jan 2005 22:12:00 +0100
From: Andi Kleen <ak@muc.de>
To: YhLu <YhLu@tyan.com>
Cc: Matt Domsch <Matt_Domsch@dell.com>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, jamesclv@us.ibm.com, suresh.b.siddha@intel.com
Subject: Re: 256 apic id for amd64
Message-ID: <20050107211200.GA36896@muc.de>
References: <3174569B9743D511922F00A0C94314230729132B@TYANWEB>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3174569B9743D511922F00A0C94314230729132B@TYANWEB>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 01:14:24PM -0800, YhLu wrote:
> After keep the bsp using 0, the jiffies works well. Werid?

Probably a bug somewhere.  But since BSP should be always 
0 I'm not sure it is worth tracking down.

-Andi
