Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261515AbVAXOYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbVAXOYP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 09:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261517AbVAXOYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 09:24:15 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:37509 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261515AbVAXOYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 09:24:12 -0500
Date: Mon, 24 Jan 2005 14:24:11 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1
Message-ID: <20050124142411.GA31611@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050124021516.5d1ee686.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050124021516.5d1ee686.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  bk-i2c.patch

This contains two new subsystems, both aren't exactly the nicest code
on earth and one isn't even explained what it is.  And both aren't
really i2c-related.

Greg, any chance you could stop funneling new tasteless code in through
the backdoor?

