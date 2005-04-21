Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261256AbVDUK3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbVDUK3N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 06:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbVDUK3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 06:29:13 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:11693 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261256AbVDUK3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 06:29:10 -0400
Subject: Re: Git-commits mailing list feed.
From: Arjan van de Ven <arjan@infradead.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
In-Reply-To: <200504210422.j3L4Mo8L021495@hera.kernel.org>
References: <200504210422.j3L4Mo8L021495@hera.kernel.org>
Content-Type: text/plain
Date: Thu, 21 Apr 2005 12:29:06 +0200
Message-Id: <1114079347.6277.29.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-21 at 14:22 +1000, David Woodhouse wrote:
> As of some time in the fairly near future, the bk-commits-head@vger mailing 
> list will be carrying real commits from Linus' live git repository, instead
> of just testing patches. Have fun.
> 

with BK this was not possible, but could we please have -p added to the
diff parameters with git ? It makes diffs a LOT more reasable!


