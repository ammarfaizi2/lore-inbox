Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264019AbUFKOml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264019AbUFKOml (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 10:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264022AbUFKOml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 10:42:41 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:54409 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264019AbUFKOmk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 10:42:40 -0400
Date: Fri, 11 Jun 2004 16:42:22 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Timothy Miller <miller@techsource.com>
Cc: Hans Reiser <reiser@namesys.com>, Dave Jones <davej@redhat.com>,
       Chris Mason <mason@suse.com>, reiserfs-dev@namesys.com,
       linux-kernel@vger.kernel.org
Subject: Re: [STACK] >3k call path in reiserfs
Message-ID: <20040611144222.GC7369@wohnheim.fh-wedel.de>
References: <1086784264.10973.236.camel@watt.suse.com> <1086800028.10973.258.camel@watt.suse.com> <40C74388.20301@namesys.com> <1086801345.10973.263.camel@watt.suse.com> <40C75141.7070408@namesys.com> <20040609182037.GA12771@redhat.com> <40C79FE2.4040802@namesys.com> <20040610223532.GB3340@wohnheim.fh-wedel.de> <40C91DA0.6060705@namesys.com> <40C9C247.4070702@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40C9C247.4070702@techsource.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 June 2004 10:31:35 -0400, Timothy Miller wrote:
> 
> Anyhow, I agree with you.  V3 should remain unchanged.  If Linux wants 
> ReiserFS AND 4K stacks, they're going to have to wait for V4.

Reiser3 appears to be safe with 4k stacks for the moment.

> From: Vladimir Saveliev <vs@namesys.com>
> [...]
> it will not be easy to make reiser4 to work with 4k stack

Reiser4 not.  What were you saying again? ;)

Jörn

-- 
It's not whether you win or lose, it's how you place the blame.
-- unknown
