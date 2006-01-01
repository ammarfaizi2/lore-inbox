Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750904AbWAAQMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750904AbWAAQMj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 11:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbWAAQMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 11:12:39 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:60569 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750895AbWAAQMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 11:12:38 -0500
Subject: Re: Arjan's noinline Patch
From: Arjan van de Ven <arjan@infradead.org>
To: Kurt Wall <kwallnator@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060101155710.GA5213@kurtwerks.com>
References: <20060101155710.GA5213@kurtwerks.com>
Content-Type: text/plain
Date: Sun, 01 Jan 2006 17:12:33 +0100
Message-Id: <1136131954.17830.40.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-01-01 at 10:57 -0500, Kurt Wall wrote:
> After applying Arjan's noline patch (http://www.fenrus.org/noinline), I
> see almost a 10% reduction in the size of .text (against 2.6.15-rc6)

wow that's a lot, more than I expected actually.... 

