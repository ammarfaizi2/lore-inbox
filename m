Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266527AbUFZXxB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266527AbUFZXxB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 19:53:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267237AbUFZXxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 19:53:01 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:53441 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S266527AbUFZXxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 19:53:00 -0400
Date: Sat, 26 Jun 2004 16:52:48 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Erik Jacobson <erikj@subway.americas.sgi.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jesse Barnes <jbarnes@engr.sgi.com>,
       Andrew Morton <akpm@osdl.org>, Pat Gefre <pfg@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] Altix serial driver
Message-ID: <20040626235248.GC12761@taniwha.stupidest.org>
References: <Pine.SGI.3.96.1040623094239.19458C-100000@fsgi900.americas.sgi.com> <20040623143801.74781235.akpm@osdl.org> <200406231754.56837.jbarnes@engr.sgi.com> <Pine.SGI.4.53.0406242153360.343801@subway.americas.sgi.com> <20040625083130.GA26557@infradead.org> <Pine.SGI.4.53.0406250742350.377639@subway.americas.sgi.com> <20040625124807.GA29937@infradead.org> <Pine.SGI.4.53.0406250751470.377692@subway.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SGI.4.53.0406250751470.377692@subway.americas.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2004 at 08:00:24AM -0500, Erik Jacobson wrote:

> I certainly had failed registrations when I tried to "share" ttyS0.

It's not clear to my why you can't use ttyS0, ttyS1, etc. since those
will probably not be used on Altix.


   --cw
