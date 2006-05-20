Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932346AbWETVH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbWETVH1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 17:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbWETVH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 17:07:26 -0400
Received: from smtp111.sbc.mail.mud.yahoo.com ([68.142.198.210]:8871 "HELO
	smtp111.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932346AbWETVHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 17:07:25 -0400
Date: Sat, 20 May 2006 14:07:23 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Christoph Hellwig <hch@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] i386: kill CONFIG_REGPARM completely
Message-ID: <20060520210722.GA932@taniwha.stupidest.org>
References: <20060520025353.GE9486@taniwha.stupidest.org> <20060520090614.GA9630@infradead.org> <20060520201357.GA32010@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060520201357.GA32010@taniwha.stupidest.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 20, 2006 at 01:13:57PM -0700, Chris Wedgwood wrote:

> +CFLAGS += -pipe -msoft-float -mregparm-3

oops, typo there in my part, i'll resend with this fixed shortly.
