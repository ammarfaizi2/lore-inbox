Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261690AbSJNPFU>; Mon, 14 Oct 2002 11:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261700AbSJNPFU>; Mon, 14 Oct 2002 11:05:20 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:56845 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261690AbSJNPFU>; Mon, 14 Oct 2002 11:05:20 -0400
Date: Mon, 14 Oct 2002 16:11:12 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Bernd Eckenfels <ecki-news2002-09@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.5.42
Message-ID: <20021014161112.A17683@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Bernd Eckenfels <ecki-news2002-09@lina.inka.de>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.33.0210131545510.17395-100000@coffee.psychology.mcmaster.ca> <E180pHX-0004a1-00@sites.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E180pHX-0004a1-00@sites.inka.de>; from ecki-news2002-09@lina.inka.de on Sun, Oct 13, 2002 at 10:24:11PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 13, 2002 at 10:24:11PM +0200, Bernd Eckenfels wrote:
> In article <Pine.LNX.4.33.0210131545510.17395-100000@coffee.psychology.mcmaster.ca> you wrote:
> > for instance, some part of EVMS design is motivated by IBM's political
> > desire to permit its bank customers, who have horrible old OS/2 systems,
> > to transparently use OS/2 volumes.
> 
> Some parts? I guess it is one module. What is wrong with this. Support for
> non standard partition and slice types is currently cluttering up the kernel
> source. I will be more than happy to see this in a EVMS module.

Umm, you consider moving coee from fs/partitions/*.c to drivers/evms/*.c
a cleanup?

