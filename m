Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263742AbUBHQGB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 11:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263760AbUBHQGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 11:06:00 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:37807 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S263742AbUBHQF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 11:05:59 -0500
Date: Sun, 8 Feb 2004 11:05:56 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: mmayer@uci.edu
cc: linux-net@vger.kernel.org, <linux-kernel@vger.kernel.org>
Subject: Re: Cisco vpnclient prevents proper shutdown starting with 2.6.2
In-Reply-To: <20040207051716.00D742EE41@ip68-4-65-241.oc.oc.cox.net>
Message-ID: <Pine.LNX.4.44.0402081103170.23588-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Feb 2004, Meinhard E. Mayer wrote:

> Until version 2.6.1 the Cisco VPN module (version 4.0.3(B)) cisco_ipsec,
> although "tainted" worked fine with all 2.4.22 and 2.6 kernel versions.
> However, for 2.6.2, although the module compiles and loads,

You should send this bug report to somebody who has the source
code to the Cisco VPN client module ... say, Cisco.

If they don't want to fix the software for you, you might want
to look into using an open source alternative for their stuff.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

