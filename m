Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261681AbVAXVvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbVAXVvf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 16:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbVAXVuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 16:50:19 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:18317 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261606AbVAXVsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 16:48:04 -0500
Date: Mon, 24 Jan 2005 21:47:51 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1: SuperIO scx200 breakage
Message-ID: <20050124214751.GA6396@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>, Adrian Bunk <bunk@stusta.de>,
	Andrew Morton <akpm@osdl.org>,
	Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	linux-kernel@vger.kernel.org
References: <20050124021516.5d1ee686.akpm@osdl.org> <20050124175449.GK3515@stusta.de> <20050124213442.GC18933@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050124213442.GC18933@kroah.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 01:34:42PM -0800, Greg KH wrote:
> And as for the "these patches have never been reviewed" comments, that's
> why I put them in my tree, and have them show up in -mm.  It's getting
> them a wider exposure and finding out these kinds of issues.  So the
> process is working properly :)

It would be a lot more productive to follow the normal rules, though.
That is posting them on lkml as properly split up patches, and with
proper descriptions of what they're doing.

