Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965108AbWJJIlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965108AbWJJIlw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 04:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965111AbWJJIlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 04:41:51 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:60563 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S965108AbWJJIlv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 04:41:51 -0400
Date: Tue, 10 Oct 2006 09:41:49 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: Adrian Bunk <bunk@stusta.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc-dev@ozlabs.org
Subject: Re: 2.6.19-rc1: known regressions (v3)
In-Reply-To: <20061010051019.GB3650@stusta.de>
Message-ID: <Pine.LNX.4.64.0610100929350.26920@skynet.skynet.ie>
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org>
 <20061010051019.GB3650@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2006, Adrian Bunk wrote:

> This email lists some known regressions in 2.6.19-rc1 compared to 2.6.18
> that are not yet fixed Linus' tree.
>
> <snip>
>
> Subject    : doesn't boot on iBook G4
> References : http://lkml.org/lkml/2006/10/5/305
> Submitter  : Andreas Schwab <schwab@suse.de>
> Handled-By : Mel Gorman <mel@skynet.ie>
> Patch      : http://lkml.org/lkml/2006/10/6/80
> Status     : patch available
>

This patch is currently in 2.6.18-rc1-mm1 and is called 
mm-use-symbolic-names-instead-of-indices-for-zone-initialisation.patch .

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
