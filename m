Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964841AbVHIQp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964841AbVHIQp3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 12:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964876AbVHIQp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 12:45:29 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:1688 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964841AbVHIQp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 12:45:28 -0400
Date: Tue, 9 Aug 2005 17:45:26 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Grzegorz Piotr Jaskiewicz <gj@kde.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: oops in VMWARE vmnet, on 2.6.12.x
Message-ID: <20050809164526.GA21622@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Petr Vandrovec <vandrove@vc.cvut.cz>,
	Grzegorz Piotr Jaskiewicz <gj@kde.org.uk>,
	linux-kernel@vger.kernel.org
References: <200508091744.33523@gj-laptop> <42F8D23D.3000505@vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42F8D23D.3000505@vc.cvut.cz>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2005 at 05:56:45PM +0200, Petr Vandrovec wrote:
> You should report problems related to the VMware at the VMware community 
> forums,
> http://www.vmware.com/community/index.jspa.  Most of peoples on LKML does 
> not
> care about these opensource modules.

Nothing in the tarball mentiones any opensource license.  If vmware is
actually using an opensource license please tell them to mention that
license and remove the propritary code markers.

