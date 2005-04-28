Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261893AbVD1Ipi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbVD1Ipi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 04:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261966AbVD1Imt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 04:42:49 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:56039 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261972AbVD1Ij2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 04:39:28 -0400
Date: Thu, 28 Apr 2005 09:39:22 +0100
From: Christoph Hellwig <hch@infradead.org>
To: aq <aquynh@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs/Kconfig: more consistent configuration of XFS
Message-ID: <20050428083922.GA11542@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	aq <aquynh@gmail.com>, Andrew Morton <akpm@osdl.org>,
	lkml <linux-kernel@vger.kernel.org>
References: <9cde8bff050428005528ecf692@mail.gmail.com> <20050428080914.GA10799@infradead.org> <9cde8bff0504280138b979c08@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cde8bff0504280138b979c08@mail.gmail.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2005 at 05:38:40PM +0900, aq wrote:
> I dont see why we should keep a file in kernel tree without using it
> (since the patch removes "source xfs/Kconfig). Anyway, here is another
> patch that doesnt remove fs/xfs/Kconfig.

No, you should not remove usage of it either.

