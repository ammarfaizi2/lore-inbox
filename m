Return-Path: <linux-kernel-owner+w=401wt.eu-S965116AbWLTOvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965116AbWLTOvt (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 09:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965118AbWLTOvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 09:51:49 -0500
Received: from smtp.saahbs.net ([70.235.213.234]:34957 "HELO smtp.saahbs.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965116AbWLTOvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 09:51:47 -0500
Date: Wed, 20 Dec 2006 08:51:45 -0600
From: Michal Sabala <lkml@saahbs.net>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18 mmap hangs unrelated apps
Message-ID: <20061220145145.GA14676@prosiaczek>
Reply-To: Michael Sabala <lkml@saahbs.net>
References: <20061215023014.GC2721@prosiaczek> <1166199855.5761.34.camel@lade.trondhjem.org> <20061215175030.GG6220@prosiaczek> <1166211884.5761.49.camel@lade.trondhjem.org> <20061215210642.GI6220@prosiaczek> <1166219054.5761.56.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <1166219054.5761.56.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006/12/15 at 15:44:14 Trond Myklebust <trond.myklebust@fys.uio.no> wrote
> On Fri, 2006-12-15 at 15:06 -0600, Michal Sabala wrote:
> >
> > What nfs_debug information would be useful in tracking this
> > problem? Is there any other information I can provide you?
> 
> Could you just out of interest try 2.6.20-rc1?

Hello Trond, Andrew,

For what it's worth, after running 2.6.20-rc1 for ~12 hours, I did not
observe the uninterruptible sleep condition.

Thanks, Michal

-- 
Michal "Saahbs" Sabala
