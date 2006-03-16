Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752408AbWCPQut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752408AbWCPQut (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 11:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752409AbWCPQut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 11:50:49 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:36522 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1752408AbWCPQus
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 11:50:48 -0500
Date: Thu, 16 Mar 2006 16:50:35 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Christoph Hellwig <hch@infradead.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, aia21@cantab.net, len.brown@intel.com
Subject: Re: [patch 1/1] consolidate TRUE and FALSE
Message-ID: <20060316165035.GU27946@ftp.linux.org.uk>
References: <200603161004.k2GA46Fc029649@shell0.pdx.osdl.net> <20060316160129.GB6407@infradead.org> <20060316082951.58592fdc.rdunlap@xenotime.net> <20060316163001.GA7222@infradead.org> <20060316083654.d802f3f3.rdunlap@xenotime.net> <20060316163621.GA7519@infradead.org> <Pine.LNX.4.64.0603161640230.31173@hermes-2.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603161640230.31173@hermes-2.csi.cam.ac.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2006 at 04:42:29PM +0000, Anton Altaparmakov wrote:
> Again, in your opinion.  To me it is a simple consequence of there not 
> being a boolean type in the kernel so you cannot use it in the core code.  
> Once there is such a type I would imagine users will appear in the core 
> code over time.

And that's supposed to be an argument in favour of that crap?
