Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263435AbUALWj7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 17:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263472AbUALWj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 17:39:59 -0500
Received: from mail.ccur.com ([208.248.32.212]:63239 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S263435AbUALWj6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 17:39:58 -0500
Date: Mon, 12 Jan 2004 17:39:49 -0500
From: Joe Korty <joe.korty@ccur.com>
To: Paul Jackson <pj@sgi.com>
Cc: hch@infradead.org, schwab@suse.de, paulus@samba.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: seperator error in __mask_snprintf_len
Message-ID: <20040112223949.GA13398@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <20040108051111.4ae36b58.pj@sgi.com> <16381.57040.576175.977969@cargo.ozlabs.ibm.com> <20040109064619.35c487ec.pj@sgi.com> <je1xq9duhc.fsf@sykes.suse.de> <20040109152533.A25396@infradead.org> <20040109092309.42bb6049.pj@sgi.com> <20040112000923.GA2743@tsunami.ccur.com> <20040112134112.2dd0ec42.pj@sgi.com> <20040112220024.GA12748@tsunami.ccur.com> <20040112142839.3dbda2d0.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040112142839.3dbda2d0.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> snprintf-like calls should behave like snprintf calls, no fancier.

You are correct.
-- 
"Money can buy bandwidth, but latency is forever" -- John Mashey
Joe
