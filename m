Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262142AbUEKGWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262142AbUEKGWr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 02:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbUEKGWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 02:22:47 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:19461 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262170AbUEKGWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 02:22:43 -0400
Date: Tue, 11 May 2004 07:22:37 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Wim Coekaerts <wim.coekaerts@oracle.com>, cw@f00f.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm1
Message-ID: <20040511072237.C12187@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>,
	Wim Coekaerts <wim.coekaerts@oracle.com>, cw@f00f.org,
	linux-kernel@vger.kernel.org
References: <20040510223755.A7773@infradead.org> <20040510150203.3257ccac.akpm@osdl.org> <20040510231146.GA5168@taniwha.stupidest.org> <20040510162818.376b4a55.akpm@osdl.org> <20040510233342.GA5614@taniwha.stupidest.org> <20040510165132.5107472e.akpm@osdl.org> <20040510235312.GA9348@taniwha.stupidest.org> <20040510171413.6c1699b8.akpm@osdl.org> <20040511002426.GD1105@ca-server1.us.oracle.com> <20040510181008.1906ea8a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040510181008.1906ea8a.akpm@osdl.org>; from akpm@osdl.org on Mon, May 10, 2004 at 06:10:08PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2004 at 06:10:08PM -0700, Andrew Morton wrote:
> > We have done the work and are going to be ok going forward to just use
> > hugeltbfs directly, just mounting it with right uid,gid. the main issue
> 
> err, so why did I just merge the hugetlb_shm_group patch?

Because we're lacking communication?  

