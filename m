Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266562AbSKGOVg>; Thu, 7 Nov 2002 09:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266563AbSKGOVg>; Thu, 7 Nov 2002 09:21:36 -0500
Received: from [198.149.18.6] ([198.149.18.6]:17337 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S266562AbSKGOVg>;
	Thu, 7 Nov 2002 09:21:36 -0500
Date: Thu, 7 Nov 2002 16:42:24 -0500
From: Christoph Hellwig <hch@sgi.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Christoph Hellwig <hch@sgi.com>, Robert Love <rml@tech9.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] set_cpus_allowed() for 2.4
Message-ID: <20021107164224.A14817@sgi.com>
Mail-Followup-To: Christoph Hellwig <hch@sgi.com>,
	Adrian Bunk <bunk@fs.tum.de>, Robert Love <rml@tech9.net>,
	linux-kernel@vger.kernel.org
References: <1033513407.12959.91.camel@phantasy> <20021104223725.A23168@sgi.com> <20021106153217.GB13905@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021106153217.GB13905@fs.tum.de>; from bunk@fs.tum.de on Wed, Nov 06, 2002 at 04:32:17PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2002 at 04:32:17PM +0100, Adrian Bunk wrote:
> On Mon, Nov 04, 2002 at 10:37:25PM -0500, Christoph Hellwig wrote:
> >...
> > now that all vendors ship a backport of Ingo's O(1) scheduler external projects
> >...
> 
> Your "all vendors" doesn't include Debian?

No.  Replace all vendors with all commercial vendors or all recently
releaseased distribution :)  

