Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267583AbUG3EBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267583AbUG3EBy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 00:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267584AbUG3EBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 00:01:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:65170 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267583AbUG3EBw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 00:01:52 -0400
Message-ID: <4109C81A.5040507@pobox.com>
Date: Fri, 30 Jul 2004 00:01:30 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Erez Zadok <ezk@cs.sunysb.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: fistgen-0.1 released (linux-2.6 support)
References: <200407291751.i6THpea3002949@agora.fsl.cs.sunysb.edu>
In-Reply-To: <200407291751.i6THpea3002949@agora.fsl.cs.sunysb.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erez Zadok wrote:
> We're pleased to announce the release of fistgen-0.1, the package of
> stackable templates.  This release includes numerous bug fixes, but biggest
> new thing is a port to Linux 2.6!
> 
> We've tested the templates under various conditions for more than two
> months: over ext2/3, over nfs, with low-memory conditions, small/large
> files, large compile benchmarks, small and large postmark configurations,
> fsx-linux, and other tests -- and permutations of these.  This exhaustive
> testing was done to help ensure that the templates are as stable as possible
> (many people are now using fist in production environments).
> 
> Get the new tarball from
> 
> 	ftp://ftp.filesystems.org/pub/fist/fistgen-0.1.tar.gz
> 
> Here's the relevant portion of the NEWS file:


And for those of us who don't know what a stackable template is?
No doubt there are many well-tested permutations in production 
environments, but still...

	Jeff


