Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268160AbTG1M4R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 08:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269269AbTG1M4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 08:56:17 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:15368 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268160AbTG1M4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 08:56:16 -0400
Date: Mon, 28 Jul 2003 14:11:28 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Christoph Hellwig <hch@infradead.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: [patch 2.6.0-test2: com20020_cs.c doesn't compile
Message-ID: <20030728141128.A9005@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adrian Bunk <bunk@fs.tum.de>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-net@vger.kernel.org, trivial@rustcorp.com.au
References: <Pine.LNX.4.44.0307271003360.3401-100000@home.osdl.org> <20030728130344.GF25402@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030728130344.GF25402@fs.tum.de>; from bunk@fs.tum.de on Mon, Jul 28, 2003 at 03:03:44PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 28, 2003 at 03:03:44PM +0200, Adrian Bunk wrote:
> The following patch fixes it:

Thanks, the fix looks correct.  The driver should prbably move
to drivers/net/arcnet while we're at it.

