Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266350AbUBFDWP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 22:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266343AbUBFDWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 22:22:15 -0500
Received: from ns.suse.de ([195.135.220.2]:50913 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266340AbUBFDWM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 22:22:12 -0500
Date: Fri, 6 Feb 2004 04:19:13 +0100
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Steve Lord <lord@xfs.org>, ak@suse.de, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com
Subject: Re: Limit hash table size
Message-ID: <20040206031913.GB24890@wotan.suse.de>
References: <B05667366EE6204181EABE9C1B1C0EB5802441@scsmsx401.sc.intel.com.suse.lists.linux.kernel> <20040205155813.726041bd.akpm@osdl.org.suse.lists.linux.kernel> <p73isilkm4x.fsf@verdi.suse.de> <4021AC9F.4090408@xfs.org> <20040205191240.13638135.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040205191240.13638135.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Was it a highmem box?  If so, was the filesystem in question placing

I doubt SGI has any big highmem linux boxes ;-) 

-Andi
