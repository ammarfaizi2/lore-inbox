Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbULBHbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbULBHbw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 02:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbULBHbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 02:31:52 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32678 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261159AbULBHbu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 02:31:50 -0500
Message-ID: <41AEC4D7.4060507@pobox.com>
Date: Thu, 02 Dec 2004 02:31:35 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, clameter@sgi.com,
       hugh@veritas.com, benh@kernel.crashing.org, nickpiggin@yahoo.com.au,
       linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V12 [0/7]: Overview and performance
 tests
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain><Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com><Pine.LNX.4.58.0411221419440.20993@ppc970.osdl.org><Pine.LNX.4.58.0411221424580.22895@schroedinger.engr.sgi.com><Pine.LNX.4.58.0411221429050.20993@ppc970.osdl.org><Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com><Pine.LNX.4.58.0412011608500.22796@ppc970.osdl.org><41AEB44D.2040805@pobox.com><20041201223441.3820fbc0.akpm@osdl.org><41AEBAB9.3050705@pobox.com> <20041201230217.1d2071a8.akpm@osdl.org> <179540000.1101972418@[10.10.2.4]>
In-Reply-To: <179540000.1101972418@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
> Yeah, probably. Though the stress tests catch a lot more than the 
> functionality ones. The big pain in the ass is drivers, because I don't
> have a hope in hell of testing more than 1% of them.

My dream is that hardware vendors rotate their current machines through 
a test shop :)  It would be nice to make sure that the popular drivers 
get daily test coverage.

	Jeff, dreaming on


