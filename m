Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266492AbUFQNo3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266492AbUFQNo3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 09:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266494AbUFQNo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 09:44:28 -0400
Received: from [213.146.154.40] ([213.146.154.40]:54955 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S266492AbUFQNo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 09:44:27 -0400
Date: Thu, 17 Jun 2004 14:44:24 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Peter Wainwright <prw@ceiriog1.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Irix NFS servers, again :-)
Message-ID: <20040617134424.GA32272@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Peter Wainwright <prw@ceiriog1.demon.co.uk>,
	linux-kernel@vger.kernel.org
References: <1087411925.30092.35.camel@ceiriog1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1087411925.30092.35.camel@ceiriog1.demon.co.uk>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2004 at 07:52:06PM +0100, Peter Wainwright wrote:
> I just upgraded one of my machines to Fedora Core 2, including
> kernel 2.6.5. I found myself bitten on the bum by a bug I thought
> had expired long ago, namely the Irix server readdir bug, or
> 32/64-bit cookie problem.
> 
> Therefore, I thought I should let you folks know that this problem
> is still there, apparently.

IIRC this was fixed on the IRIX side a while ago.  What IRIX version
do you run?

