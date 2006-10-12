Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbWJLTBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbWJLTBV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 15:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWJLTBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 15:01:21 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:23970 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750789AbWJLTBU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 15:01:20 -0400
Subject: Re: 2.6.19-rc1-mm1
From: Badari Pulavarty <pbadari@gmail.com>
To: Vadim Lobanov <vlobanov@speakeasy.net>
Cc: Andrew Morton <akpm@osdl.org>, "Martin J. Bligh" <mbligh@google.com>,
       lkml <linux-kernel@vger.kernel.org>, Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <200610121152.19649.vlobanov@speakeasy.net>
References: <20061010000928.9d2d519a.akpm@osdl.org>
	 <20061011144713.cb0c1453.akpm@osdl.org>
	 <1160676589.9386.18.camel@dyn9047017100.beaverton.ibm.com>
	 <200610121152.19649.vlobanov@speakeasy.net>
Content-Type: text/plain
Date: Thu, 12 Oct 2006 12:01:00 -0700
Message-Id: <1160679660.9386.20.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-12 at 11:52 -0700, Vadim Lobanov wrote:
> On Thursday 12 October 2006 11:09, Badari Pulavarty wrote:
> > create05 test hang goes away with hot-fix (revert-fd-table stuff).
> > FYI.
> 
> Does it also go away with the "Eradicate fdarray overflow" patch instead of 
> the hot-fix?

I just verified. Test hang goes away with your overflow fix.

Thanks,
Badari

