Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262287AbUK3ThY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262287AbUK3ThY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 14:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262293AbUK3ThW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 14:37:22 -0500
Received: from canuck.infradead.org ([205.233.218.70]:20488 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262295AbUK3Tgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 14:36:50 -0500
Subject: Re: 2.6.10-rc2-mm4
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041130103218.513b8ce0.akpm@osdl.org>
References: <20041130095045.090de5ea.akpm@osdl.org>
	 <1101837994.2640.67.camel@laptop.fenrus.org>
	 <20041130102105.21750596.akpm@osdl.org>
	 <1101839110.2640.69.camel@laptop.fenrus.org>
	 <20041130103218.513b8ce0.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1101843401.2640.73.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Tue, 30 Nov 2004 20:36:41 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-30 at 10:32 -0800, Andrew Morton wrote:
> "This helps mainly graphic drivers who really need a lot of memory below
> the 4GB area.

oh.. it's a hook for the binary nvidia module.... 
might as well call the patch that then :)


