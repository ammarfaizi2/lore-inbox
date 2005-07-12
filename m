Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261446AbVGLOWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbVGLOWY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 10:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbVGLOWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 10:22:22 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:64175 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261458AbVGLOVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 10:21:52 -0400
Date: Tue, 12 Jul 2005 15:21:51 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [43/48] Suspend2 2.1.9.8 for 2.6.12: 619-userspace-nofreeze.patch
Message-ID: <20050712142151.GA4747@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Nigel Cunningham <ncunningham@cyclades.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <11206164393426@foobar.com> <1120616444351@foobar.com> <20050710231508.GI513@infradead.org> <1121149739.13869.7.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121149739.13869.7.camel@localhost>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2005 at 04:29:00PM +1000, Nigel Cunningham wrote:
> People need to be able to recognise when this happens. They therefore
> need some feedback to know that the process is not hung, and to be able
> to say where it hung when it does.

this is called printk.

