Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263971AbUFKOHx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263971AbUFKOHx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 10:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263963AbUFKOHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 10:07:53 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:62086 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S263943AbUFKOHv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 10:07:51 -0400
Date: Fri, 11 Jun 2004 16:07:22 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Rik van Riel <riel@redhat.com>
Cc: John Bradford <john@grabjohn.com>, Matt Mackall <mpm@selenic.com>,
       Christian Borntraeger <linux-kernel@borntraeger.net>,
       linux-kernel@vger.kernel.org,
       Lasse K?rkk?inen / Tronic <tronic2@sci.fi>
Subject: Re: Some thoughts about cache and swap
Message-ID: <20040611140721.GB7369@wohnheim.fh-wedel.de>
References: <200406091932.i59JWh0N000383@81-2-122-30.bradfords.org.uk> <Pine.LNX.4.44.0406091528410.3620-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0406091528410.3620-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 June 2004 15:32:41 -0400, Rik van Riel wrote:
> 
> Haven't seen many of those, to be honest.  The majority
> of the VM problems I get to see are people running a
> workload the kernel didn't expect - a workload the kernel
> wasn't prepared to handle...

Is there a list of those different workloads somewhere?  And I don't
mean in your head. ;)

All I notive in my personal use is the cache flushing effect from
use-once data.  If that was the whole list, it should be easy enough
to fix.

Jörn

-- 
"Security vulnerabilities are here to stay."
-- Scott Culp, Manager of the Microsoft Security Response Center, 2001
