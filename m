Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268597AbUHLQQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268597AbUHLQQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 12:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268600AbUHLQQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 12:16:25 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:9709 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S268597AbUHLQPu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 12:15:50 -0400
Subject: Re: [PATCH] Remove whitespace from ALI15x3 IDE driver name
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Christoph Hellwig <hch@infradead.org>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org
In-Reply-To: <20040812170400.A2448@infradead.org>
References: <1092336877.7433.1.camel@localhost>
	 <20040812170400.A2448@infradead.org>
Message-Id: <1092338360.7433.5.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 12 Aug 2004 19:19:20 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Thu, Aug 12, 2004 at 06:54:38PM +0000, Pekka Enberg wrote:
> > This patch removes whitespace from ALI15x3 IDE driver name that appears in the
> > sysfs directory. It is against 2.6.7.

On Thu, 2004-08-12 at 16:04, Christoph Hellwig wrote:
> You jnow that this breaks every tool that knew of the names so far?  E.g.
> Debian mkinitrd (now has a patch to deal with both the whitespace and
> non-whitespace variants) and probably quite a few installers out there.

Sorry, I did not know that. I only booted to my Gentoo box with it. I
saw similar patches go into other PCI drivers which is why I thought it
was appropriate.

		Pekka

