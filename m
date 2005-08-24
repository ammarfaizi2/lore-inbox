Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751006AbVHXOLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbVHXOLP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 10:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751007AbVHXOLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 10:11:15 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:60343 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750993AbVHXOLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 10:11:15 -0400
Date: Wed, 24 Aug 2005 15:11:12 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Rafael Esp?ndola <rafael.espindola@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       itautec@las.ic.unicamp.br, ltc@las.ic.unicamp.br
Subject: Re: conexant modem driver for 2.6.12
Message-ID: <20050824141112.GA30906@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Rafael Esp?ndola <rafael.espindola@gmail.com>,
	linux-kernel@vger.kernel.org, itautec@las.ic.unicamp.br,
	ltc@las.ic.unicamp.br
References: <200508232128.43099.rafael.espindola@gmail.com> <20050824073954.GE24513@infradead.org> <564d96fb05082407097eed2c53@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <564d96fb05082407097eed2c53@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2005 at 11:09:38AM -0300, Rafael Esp?ndola wrote:
> On 8/24/05, Christoph Hellwig <hch@infradead.org> wrote:
> > Please don't announce propitarty drivers on lkml, thanks.
> Sorry, but my intent with this drivers is to make them as free as
> possible. I have ported the old driver because the only non-free files
> are the .Os

which is a binary driver.  As I mentioned please stay away with that
stuff.  The only reason to post anything about it here was if you
reverse-engineered their binary objects and were looking for someone
to implement a driver based on the specification.

