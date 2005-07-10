Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262202AbVGJXN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262202AbVGJXN3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 19:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262197AbVGJXLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 19:11:19 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:7654 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262196AbVGJXJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 19:09:06 -0400
Date: Mon, 11 Jul 2005 00:09:01 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [10/48] Suspend2 2.1.9.8 for 2.6.12: 360-reset-kswapd-max-order-after-resume.patch
Message-ID: <20050710230901.GG513@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Nigel Cunningham <nigel@suspend2.net>, linux-kernel@vger.kernel.org
References: <11206164393426@foobar.com> <11206164403365@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11206164403365@foobar.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So what is this doing, and is it breaking swsusp support?

