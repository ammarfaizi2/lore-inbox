Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263106AbTCSP0O>; Wed, 19 Mar 2003 10:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263107AbTCSP0O>; Wed, 19 Mar 2003 10:26:14 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:32520 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263106AbTCSP0N>; Wed, 19 Mar 2003 10:26:13 -0500
Date: Wed, 19 Mar 2003 15:37:07 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 2.5.65-mjb1: lkcd: EXTRA_TARGETS is obsolete
Message-ID: <20030319153707.A24084@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adrian Bunk <bunk@fs.tum.de>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <8230000.1047975763@[10.10.2.4]> <20030319153304.GC23258@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030319153304.GC23258@fs.tum.de>; from bunk@fs.tum.de on Wed, Mar 19, 2003 at 04:33:04PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 19, 2003 at 04:33:04PM +0100, Adrian Bunk wrote:
> On Tue, Mar 18, 2003 at 12:22:43AM -0800, Martin J. Bligh wrote:
> >...
> > lkcd						LKCD team
> > 	Linux kernel crash dump support
> >...
> 
> EXTRA_TARGETS is obsolete in 2.5.
> 
> The following should do the same:

No, kerntypes.o should not be linked into the kernel image.

