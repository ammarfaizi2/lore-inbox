Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261653AbVAGW0C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261653AbVAGW0C (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 17:26:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbVAGWYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 17:24:00 -0500
Received: from colin2.muc.de ([193.149.48.15]:14606 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261641AbVAGWSg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 17:18:36 -0500
Date: 7 Jan 2005 23:18:29 +0100
Date: Fri, 7 Jan 2005 23:18:29 +0100
From: Andi Kleen <ak@muc.de>
To: YhLu <YhLu@tyan.com>
Cc: Matt Domsch <Matt_Domsch@dell.com>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, jamesclv@us.ibm.com, suresh.b.siddha@intel.com
Subject: Re: 256 apic id for amd64
Message-ID: <20050107221829.GA56810@muc.de>
References: <3174569B9743D511922F00A0C943142307291332@TYANWEB>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3174569B9743D511922F00A0C943142307291332@TYANWEB>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 01:44:19PM -0800, YhLu wrote:
> Can you consider to use c->x86_apicid to get phy_proc_id, that is initial
> apicid.?

Where? 

-Andi

