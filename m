Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261287AbULHSK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbULHSK1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 13:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbULHSKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 13:10:15 -0500
Received: from fw.osdl.org ([65.172.181.6]:55694 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261287AbULHSGB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 13:06:01 -0500
Date: Wed, 8 Dec 2004 10:05:57 -0800
From: Chris Wright <chrisw@osdl.org>
To: FoObArf00@netscape.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: IGMP packets?
Message-ID: <20041208100556.F469@build.pdx.osdl.net>
References: <123E01F1.3018C387.023DF18B@netscape.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <123E01F1.3018C387.023DF18B@netscape.net>; from FoObArf00@netscape.net on Mon, Dec 06, 2004 at 07:29:18PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* FoObArf00@netscape.net (FoObArf00@netscape.net) wrote:
> I have been trying to analyze igmp packets (queries, reports) with
> ttl of 1 ,of course, in the kernel and ran into a weird situation.
> Only when an interface is in promiscuous mode (i.e. tcpdump), the igmp
> packets get to ip_rcv on ip_input.c.  I was wondering if someone can
> point in the right direction on how/where to get the these packets when
> not doing a tcpdump.  Thanks

Could you be more specific?  Which machines are involved (e.g. IIRC the
igmp report is not looped back locally).  What do you mean by analyze in
the kernel?

thanks,
-chris
