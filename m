Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262398AbVBBPH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262398AbVBBPH3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 10:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262384AbVBBPH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 10:07:29 -0500
Received: from canuck.infradead.org ([205.233.218.70]:16390 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262420AbVBBPHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 10:07:21 -0500
Subject: Re: Copyright / licensing question
From: Arjan van de Ven <arjan@infradead.org>
To: Frank klein <frnk_kln@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050202144915.94462.qmail@web42106.mail.yahoo.com>
References: <20050202144915.94462.qmail@web42106.mail.yahoo.com>
Content-Type: text/plain
Date: Wed, 02 Feb 2005 16:07:15 +0100
Message-Id: <1107356835.4143.109.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.3 (/)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (0.3 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-02-02 at 06:49 -0800, Frank klein wrote:
> Hi,
>  I have got an offer to write a book on Linux
> filesystems. In this I would like to cover existing
> filesystems like ext3, xfs etc. I would also cover
> embedded file systems such as jffs,ROMfs,cramsf etc.
> 
> I am having some licensing questions. It would be
> really great if you can clarify on them
> 
> 1. For explaining the internals of a filesystem in
> detail, I need to take their code from kernel sources
> 'as it is' in the book. Do I need to take any
> permissions from the owner/maintainer regarding this ?
> Will it violate any license if reproduce the driver
> source code in my book ??

no.
However what you SHOULD do is attribute the code properly and point the
reader clearly at the origin and to the fact that the code is licensed
under the terms of the GPL only. (or in case of dual license, well you
get the point)


