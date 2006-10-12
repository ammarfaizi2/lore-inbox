Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751059AbWJLSKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbWJLSKP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 14:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbWJLSKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 14:10:14 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:46489 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751059AbWJLSKL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 14:10:11 -0400
Subject: Re: 2.6.19-rc1-mm1
From: Badari Pulavarty <pbadari@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Martin J. Bligh" <mbligh@google.com>, lkml <linux-kernel@vger.kernel.org>,
       Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <20061011144713.cb0c1453.akpm@osdl.org>
References: <20061010000928.9d2d519a.akpm@osdl.org>
	 <452D4D17.1090705@google.com>  <20061011144713.cb0c1453.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 12 Oct 2006 11:09:49 -0700
Message-Id: <1160676589.9386.18.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-11 at 14:47 -0700, Andrew Morton wrote:
> On Wed, 11 Oct 2006 12:59:19 -0700
> "Martin J. Bligh" <mbligh@google.com> wrote:
> 
> > Andrew Morton wrote:
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc1/2.6.19-rc1-mm1/
> > >
> > >
> > > -
> > >   
> > 
> > Oh, and hangs in LTP.
> > 
> > x86_64 just hangs.
> > http://test.kernel.org/abat/54544/debug/test.log.1 (in something io-ish)
> > 
> 
> What makes you thing it was something io-ish?

create05 test hang goes away with hot-fix (revert-fd-table stuff).
FYI.

Thanks,
Badari



