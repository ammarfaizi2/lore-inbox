Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261710AbULBSUo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbULBSUo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 13:20:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbULBSUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 13:20:44 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:37341 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261702AbULBSUe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 13:20:34 -0500
To: cliff white <cliffw@osdl.org>
cc: Jeff Garzik <jgarzik@pobox.com>, mbligh@aracnet.com, akpm@osdl.org,
       torvalds@osdl.org, clameter@sgi.com, hugh@veritas.com,
       benh@kernel.crashing.org, nickpiggin@yahoo.com.au, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: page fault scalability patch V12 [0/7]: Overview and performance tests 
In-reply-to: Your message of Thu, 02 Dec 2004 10:10:29 PST.
             <20041202101029.7fe8b303.cliffw@osdl.org> 
Date: Thu, 02 Dec 2004 10:17:55 -0800
Message-Id: <E1CZvWd-0001hv-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 02 Dec 2004 10:10:29 PST, cliff white wrote:
> On Thu, 02 Dec 2004 02:31:35 -0500
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
> > Martin J. Bligh wrote:
> > > Yeah, probably. Though the stress tests catch a lot more than the 
> > > functionality ones. The big pain in the ass is drivers, because I don't
> > > have a hope in hell of testing more than 1% of them.
> > 
> > My dream is that hardware vendors rotate their current machines through 
> > a test shop :)  It would be nice to make sure that the popular drivers 
> > get daily test coverage.
> > 
> > 	Jeff, dreaming on
> 
> OSDL has recently re-done the donation policy, and we're much better positioned
> to support that sort of thing now - Contact Tom Hanrahan at OSDL if you 
> are a vendor, or know a vendor. ( Or you can become a vendor ) 

Specifically Tom Hanrahan == hanrahat@osdl.org

gerrit
