Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbUKEUW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbUKEUW4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 15:22:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbUKEUW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 15:22:56 -0500
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:31693 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261201AbUKEUWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 15:22:52 -0500
Date: Fri, 5 Nov 2004 21:22:49 +0100
From: Michael Gernoth <simigern@stud.uni-erlangen.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Hanging NFS umounts with 2.4.27
Message-ID: <20041105202249.GA24025@cip.informatik.uni-erlangen.de>
References: <20041105100237.GA27689@cip.informatik.uni-erlangen.de> <1099684541.19858.1.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099684541.19858.1.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2004 at 11:55:41AM -0800, Trond Myklebust wrote:
> fr den 05.11.2004 Klokka 11:02 (+0100) skreiv Michael Gernoth:
> 
> > Searching through the Changesets I found 1.1402.1.19:
> > http://linux.bkbits.net:8080/linux-2.4/cset@1.1402.1.19
> > After reverting this one, we have a stable umount-behaviour again.
> 
> Does the attached patch help at all?

Just applied it and rebooted the machines.
I can say more on monday when the next horde of users are
working on the machines.

Thanks,
  Michael
