Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266517AbUBSHpk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 02:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266555AbUBSHpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 02:45:40 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:39301 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S266517AbUBSHpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 02:45:39 -0500
Date: Wed, 18 Feb 2004 13:41:56 +0100
From: Pavel Machek <pavel@suse.cz>
To: Steve Lord <lord@xfs.org>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com
Subject: Re: Limit hash table size
Message-ID: <20040218124156.GA467@openzaurus.ucw.cz>
References: <B05667366EE6204181EABE9C1B1C0EB5802441@scsmsx401.sc.intel.com.suse.lists.linux.kernel> <20040205155813.726041bd.akpm@osdl.org.suse.lists.linux.kernel> <p73isilkm4x.fsf@verdi.suse.de> <4021AC9F.4090408@xfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4021AC9F.4090408@xfs.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Hmm, looks like Pavel maybe just hit something along these lines... 
> see
> 
> '2.6.2 extremely unresponsive after rsync backup'
> 

I tried to reproduce it and I could not. Not sure what went wrong
that night, but it does not want to happen again.

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

