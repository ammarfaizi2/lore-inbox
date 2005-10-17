Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbVJQJOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbVJQJOu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 05:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbVJQJOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 05:14:50 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:51926 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932220AbVJQJOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 05:14:49 -0400
Date: Mon, 17 Oct 2005 10:14:22 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: dipankar@in.ibm.com, Jean Delvare <khali@linux-fr.org>, torvalds@osdl.org,
       Serge Belyshev <belyshev@depni.sinp.msu.ru>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: VFS: file-max limit 50044 reached
Message-ID: <20051017091422.GA18882@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Eric Dumazet <dada1@cosmosbay.com>, dipankar@in.ibm.com,
	Jean Delvare <khali@linux-fr.org>, torvalds@osdl.org,
	Serge Belyshev <belyshev@depni.sinp.msu.ru>,
	LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
	Manfred Spraul <manfred@colorfullife.com>
References: <Pine.LNX.4.64.0510161912050.23590@g5.osdl.org> <JTFDVq8K.1129537967.5390760.khali@localhost> <20051017084609.GA6257@in.ibm.com> <43536A6C.102@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43536A6C.102@cosmosbay.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2005 at 11:10:04AM +0200, Eric Dumazet wrote:
> Dont take me wrong : I really *need* the file RCU stuff added in 2.6.14.

how so? and why should we care?  I'd rather see a 2.6.14 soon with
the changes backed out so we can have a proper release that more or
less sticks to the release schedule we agreed on at kernel summit.
You'll have four weeks time to sort out the issue afterwards.
