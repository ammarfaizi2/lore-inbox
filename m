Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262132AbUEKGVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262132AbUEKGVj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 02:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbUEKGVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 02:21:39 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:17669 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262132AbUEKGVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 02:21:34 -0400
Date: Tue, 11 May 2004 07:21:32 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Chris Wedgwood <cw@f00f.org>, hch@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm1
Message-ID: <20040511072132.B12187@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, Chris Wedgwood <cw@f00f.org>,
	linux-kernel@vger.kernel.org
References: <20040510024506.1a9023b6.akpm@osdl.org> <20040510223755.A7773@infradead.org> <20040510150203.3257ccac.akpm@osdl.org> <20040510231146.GA5168@taniwha.stupidest.org> <20040510162818.376b4a55.akpm@osdl.org> <20040510233342.GA5614@taniwha.stupidest.org> <20040510165132.5107472e.akpm@osdl.org> <20040510235312.GA9348@taniwha.stupidest.org> <20040510171413.6c1699b8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040510171413.6c1699b8.akpm@osdl.org>; from akpm@osdl.org on Mon, May 10, 2004 at 05:14:13PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2004 at 05:14:13PM -0700, Andrew Morton wrote:
> Migrating away from this will require work from vendors, Oracle, PAM
> developers, /bin/login and /bin/su developers.  Until that has happened I
> think we should arrange for vendor kernels and kernel.org kernels to offer
> the same interfaces.
> 
> And I don't think pulling the feature out of kernel.org kernels will
> provide any added stimulus, frankly.  They'll just ship the hack and go off
> to do something else.
> 
> If someone had done the kernel and userspace work 6-12 months ago then
> sure, we wouldn't be in this situation.

Well, the question is why did those folks who care about it (Oracle it
seems) not do it 6-12 month ago?

This oh shit oracle needs it we need to come up with a hack mentality
sucks big time.  If oracle (or $ISV/$IHV) they should send patches in
time so we can discuss it.  In fact these patches don't even come from
Oracle but from Intel which shows something is seriously wrong with all
this.

