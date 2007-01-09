Return-Path: <linux-kernel-owner+w=401wt.eu-S1751326AbXAIKsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbXAIKsY (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 05:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbXAIKsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 05:48:24 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:53738 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326AbXAIKsX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 05:48:23 -0500
Date: Tue, 9 Jan 2007 10:48:15 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Cc: Christoph Hellwig <hch@infradead.org>, Erez Zadok <ezk@cs.sunysb.edu>,
       Andrew Morton <akpm@osdl.org>, Shaya Potter <spotter@cs.columbia.edu>,
       "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk, torvalds@osdl.org, mhalcrow@us.ibm.com,
       David Quigley <dquigley@cs.sunysb.edu>
Subject: Re: [PATCH 01/24] Unionfs: Documentation
Message-ID: <20070109104815.GB22227@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Josef Sipek <jsipek@fsl.cs.sunysb.edu>,
	Erez Zadok <ezk@cs.sunysb.edu>, Andrew Morton <akpm@osdl.org>,
	Shaya Potter <spotter@cs.columbia.edu>,
	Josef 'Jeff' Sipek <jsipek@cs.sunysb.edu>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	viro@ftp.linux.org.uk, torvalds@osdl.org, mhalcrow@us.ibm.com,
	David Quigley <dquigley@cs.sunysb.edu>
References: <20070108140224.3a814b7d.akpm@osdl.org> <200701090003.l0903Z2O017720@agora.fsl.cs.sunysb.edu> <20070109095345.GB12406@infradead.org> <20070109104333.GC25438@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070109104333.GC25438@filer.fsl.cs.sunysb.edu>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2007 at 05:43:33AM -0500, Josef Sipek wrote:
> > I think that's an very important point.  We have a chance to get that
> > non-fanout filesystems right quite easily - something I wished that would
> > have been done before the ecryptfs merge - while getting fan-out stackable
> > filesystems is a really hard task.
> 
> Hard or harder?

Hard as in really hard.
