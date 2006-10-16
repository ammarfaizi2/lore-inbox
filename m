Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751505AbWJPLLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbWJPLLJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 07:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbWJPLLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 07:11:09 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:26023 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751505AbWJPLLH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 07:11:07 -0400
Date: Mon, 16 Oct 2006 21:10:51 +1000
From: Greg Banks <gnb@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, neilb@suse.de, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1 of 4] cpumask: add highest_possible_node_id
Message-ID: <20061016111051.GH8568@sgi.com>
References: <1154669719.21040.2351.camel@hole.melbourne.sgi.com> <20061016035644.1c99ad9b.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061016035644.1c99ad9b.pj@sgi.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2006 at 03:56:44AM -0700, Paul Jackson wrote:
> This patch (of August 3, 2006) added (after a bit of fixing) a nodemask
> related routine to lib/cpumask.c.  Granted, there is no lib/nodemask.c,
> and Andrew suggested lib/cpumask.c.
> 
> But at least it should have added
> 
> 	#include <linux/nodemask.h>
> 
> to lib/cpumask.c, no?

Sure.

Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.
