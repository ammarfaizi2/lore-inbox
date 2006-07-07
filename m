Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbWGGKVI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbWGGKVI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 06:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbWGGKVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 06:21:07 -0400
Received: from postel.suug.ch ([194.88.212.233]:55713 "EHLO postel.suug.ch")
	by vger.kernel.org with ESMTP id S932088AbWGGKVG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 06:21:06 -0400
Date: Fri, 7 Jul 2006 12:21:27 +0200
From: Thomas Graf <tgraf@suug.ch>
To: Andrew Morton <akpm@osdl.org>
Cc: Shailabh Nagar <nagar@watson.ibm.com>, jlan@sgi.com, pj@sgi.com,
       Valdis.Kletnieks@vt.edu, balbir@in.ibm.com, csturtiv@sgi.com,
       linux-kernel@vger.kernel.org, hadi@cyberus.ca, netdev@vger.kernel.org
Subject: Re: [PATCH] per-task delay accounting taskstats interface: control exit data through cpumasks]
Message-ID: <20060707102127.GC14627@postel.suug.ch>
References: <44ACD7C3.5040008@watson.ibm.com> <20060706025633.cd4b1c1d.akpm@osdl.org> <1152185865.5986.15.camel@localhost.localdomain> <20060706120835.GY14627@postel.suug.ch> <20060706144808.1dd5fadf.akpm@osdl.org> <44AD8E65.70006@watson.ibm.com> <20060706155643.2cd37b80.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060706155643.2cd37b80.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@osdl.org> 2006-07-06 15:56
> Yup.  Thomas, what's the testing status of the netlink patch you sent?  Should I
> queue it up and start plagueing people with it?

It survived feeding it with oversized strings etc. Feel free
to queue it up.
