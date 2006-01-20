Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751048AbWATQPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbWATQPy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 11:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbWATQPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 11:15:54 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:19137 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751031AbWATQPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 11:15:53 -0500
Date: Fri, 20 Jan 2006 16:15:50 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Hubert Tonneau <hubert.tonneau@fullpliant.org>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       neilb@cse.unsw.edu.au
Subject: Re: [PATCH 000 of 5] md: Introduction
Message-ID: <20060120161549.GA20681@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Hubert Tonneau <hubert.tonneau@fullpliant.org>,
	alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
	neilb@cse.unsw.edu.au
References: <0610HXV12@briare1.heliogroup.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0610HXV12@briare1.heliogroup.fr>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2006 at 05:01:06PM +0000, Hubert Tonneau wrote:
> In the U160 category, the symbios driver passed all possible stress tests
> (partly bad drives that require the driver to properly reset and restart),
> but in the U320 category, neither the Fusion not the AIC79xx did.

Please report any fusion problems to Eric Moore at LSI, the Adaptec driver
must unfortunately be considered unmaintained.

