Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262054AbULaNpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262054AbULaNpN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 08:45:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262055AbULaNpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 08:45:13 -0500
Received: from canuck.infradead.org ([205.233.218.70]:30732 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262054AbULaNpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 08:45:09 -0500
Subject: Re: why there is different kernel versions from RedHat?
From: Arjan van de Ven <arjan@infradead.org>
To: linux lover <linux_lover2004@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041231133525.47475.qmail@web52205.mail.yahoo.com>
References: <20041231133525.47475.qmail@web52205.mail.yahoo.com>
Content-Type: text/plain
Date: Fri, 31 Dec 2004 14:45:03 +0100
Message-Id: <1104500703.5402.24.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
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

On Fri, 2004-12-31 at 05:35 -0800, linux lover wrote:
> Hi all,
> Where can i get special pathces used by RedHat to
> original kernels from www.kernel.org?

from the .src.rpm's that Red Hat includes with their distribution.
It even has then described in the .spec file.


