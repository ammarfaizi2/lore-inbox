Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261891AbVASUsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbVASUsx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 15:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261888AbVASUra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 15:47:30 -0500
Received: from fw.osdl.org ([65.172.181.6]:1000 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261887AbVASUrO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 15:47:14 -0500
Date: Wed, 19 Jan 2005 12:47:13 -0800
From: Chris Wright <chrisw@osdl.org>
To: "Bill Rugolsky Jr." <brugolsky@yahoo.com>, Chris Wright <chrisw@osdl.org>,
       Jan Knutar <jk-lkml@sci.fi>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] /proc/<pid>/rlimit
Message-ID: <20050119124712.M24171@build.pdx.osdl.net>
References: <20050118204457.GA7824@ti64.telemetry-investments.com> <200501192131.59252.jk-lkml@sci.fi> <20050119113803.I469@build.pdx.osdl.net> <20050119201329.GC22710@ti64.telemetry-investments.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050119201329.GC22710@ti64.telemetry-investments.com>; from brugolsky@yahoo.com on Wed, Jan 19, 2005 at 03:13:30PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Bill Rugolsky Jr. (brugolsky@yahoo.com) wrote:
> Chris, on the other point that you made regarding UGO read access to "rlimit",
> the same is true of "maps" (at least sans SELinux policy), so I don't
> see an issue.  Certainly the map information is more security sensitive.

Yeah, I can't think of any offhand, just defaulting to paranoid ;-)

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
