Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265315AbUHOSKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265315AbUHOSKE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 14:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266837AbUHOSKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 14:10:04 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:8453 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265315AbUHOSKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 14:10:02 -0400
Date: Sun, 15 Aug 2004 19:09:17 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Deepak Saxena <dsaxena@plexity.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Christoph Hellwig <hch@infradead.org>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove whitespace from ALI15x3 IDE driver name
Message-ID: <20040815190917.B3485@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Deepak Saxena <dsaxena@plexity.net>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Pekka Enberg <penberg@cs.helsinki.fi>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1092336877.7433.1.camel@localhost> <20040812170400.A2448@infradead.org> <1092340343.22362.8.camel@localhost.localdomain> <20040812213301.GA5876@plexity.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040812213301.GA5876@plexity.net>; from dsaxena@plexity.net on Thu, Aug 12, 2004 at 02:33:01PM -0700
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2004 at 02:33:01PM -0700, Deepak Saxena wrote:
> Not having touched installer code, can someone enlighten me on
> why the installer would break with 's/ /_' or any other change
> to driver name?

driver name <-> module name mapping

