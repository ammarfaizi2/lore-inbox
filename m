Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964791AbVIKHGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791AbVIKHGQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 03:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964792AbVIKHGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 03:06:16 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:16328 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964791AbVIKHGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 03:06:16 -0400
Subject: Re: [GIT PATCH] Remove devfs from 2.6.13
From: Arjan van de Ven <arjan@infradead.org>
To: David Lang <david.lang@digitalinsight.com>
Cc: Greg KH <gregkh@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.62.0509102257290.29141@qynat.qvtvafvgr.pbz>
References: <20050909214542.GA29200@kroah.com>
	 <Pine.LNX.4.62.0509101742300.28852@qynat.qvtvafvgr.pbz>
	 <20050911030726.GA20462@suse.de>
	 <Pine.LNX.4.62.0509102257290.29141@qynat.qvtvafvgr.pbz>
Content-Type: text/plain
Date: Sun, 11 Sep 2005 09:05:44 +0200
Message-Id: <1126422344.3224.4.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-09-10 at 23:08 -0700, David Lang wrote:
> 
> remember that the distros don't package every kernel

nor do distros use devfs :)


