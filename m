Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262162AbVGJXLO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262162AbVGJXLO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 19:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbVGJXIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 19:08:43 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:5606 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262162AbVGJXH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 19:07:26 -0400
Date: Mon, 11 Jul 2005 00:07:25 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [12/48] Suspend2 2.1.9.8 for 2.6.12: 402-mtrr-remove-sysdev.patch
Message-ID: <20050710230725.GE513@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Nigel Cunningham <nigel@suspend2.net>, linux-kernel@vger.kernel.org
References: <11206164393426@foobar.com> <11206164401476@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11206164401476@foobar.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So what's this deep magic doing?  And why do you add such crude function for
debug pagealloc builds only?

