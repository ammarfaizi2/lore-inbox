Return-Path: <linux-kernel-owner+w=401wt.eu-S1763160AbWLKWOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763160AbWLKWOv (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 17:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763158AbWLKWOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 17:14:51 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:58373 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763160AbWLKWOu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 17:14:50 -0500
Date: Mon, 11 Dec 2006 22:14:45 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Christoph Hellwig <hch@infradead.org>, linuxppc-dev@ozlabs.org,
       paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc: "IRQ probe failed (0x0)" on powerbook
Message-ID: <20061211221445.GA17999@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	linux-kernel@vger.kernel.org
References: <87lklg9rkz.fsf@briny.internal.ondioline.org> <20061211112017.GA16399@infradead.org> <1165868903.7260.53.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1165868903.7260.53.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2006 at 07:28:23AM +1100, Benjamin Herrenschmidt wrote:
> > Same here, btw - except that I couldn't catch the exact message as
> > nicely.
> 
> Yeah, fixed in the patch I sent yesterday [PATCH] powerpc: Fix irq
> routing on some PowerMac 32 bit.

Confirmed, everything is fine with that patch.
