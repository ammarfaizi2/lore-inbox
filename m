Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261621AbTIOVFL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 17:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbTIOVFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 17:05:11 -0400
Received: from tux.rsn.bth.se ([194.47.143.135]:9606 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id S261621AbTIOVFH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 17:05:07 -0400
Subject: Re: Monster file_lock_cache entry in /proc/slabinfo
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: "James H. Cloos Jr." <cloos@jhcloos.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@osdl.org>
In-Reply-To: <m38yop22jt.fsf@lugabout.jhcloos.org>
References: <m3k78923wy.fsf@lugabout.jhcloos.org>
	 <20030915132514.0bee90bc.akpm@osdl.org>
	 <20030915134202.A1378@osdlab.pdx.osdl.net>
	 <m38yop22jt.fsf@lugabout.jhcloos.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063659904.2500.4.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 15 Sep 2003 23:05:05 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-09-15 at 22:56, James H. Cloos Jr. wrote:
> Is file_lock_cache only a recent issue, then?  The slowdown has been
> going on for at least the last 20 or so release tags.
> 
> If this is new I probably need to look at htree or the possibility
> that it is a disk firmware issue (it being a laptop and all)....

This has been with us for some time, it just got fixed :)

-- 
/Martin
