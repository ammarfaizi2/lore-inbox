Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261768AbULMRfI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261768AbULMRfI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 12:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbULMRfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 12:35:07 -0500
Received: from canuck.infradead.org ([205.233.218.70]:23044 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261320AbULMRcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 12:32:10 -0500
Subject: Re: phram problems and patch
From: David Woodhouse <dwmw2@infradead.org>
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Marcin Gibu?a <mg@iceni.pl>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20041213172816.GB27124@wohnheim.fh-wedel.de>
References: <200412131805.53788@senat>
	 <20041213172816.GB27124@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Dec 2004 17:31:58 +0000
Message-Id: <1102959118.13016.5.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.dwmw2.1) 
Content-Transfer-Encoding: 8bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-12-13 at 18:28 +0100, Jörn Engel wrote:
> According to David, it's on it's way. 

It's on its way and is already in the -mm tree. Should be in Linus' tree
soon after 2.6.10 is released.

>  There are more patches pending, though.

Assuming you mean the other bits you already committed to CVS, those are
in bk://linux-mtd.bkbits.net/mtd-2.6 as of this morning, and should
hence be in the next -mm release too.

-- 
dwmw2

