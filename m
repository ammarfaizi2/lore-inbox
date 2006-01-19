Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964948AbWASGkH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964948AbWASGkH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 01:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964956AbWASGkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 01:40:07 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:32723 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964948AbWASGkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 01:40:06 -0500
Subject: Re: - add-pselect-ppoll-system-call-implementation-tidy.patch
	removed from -mm tree
From: David Woodhouse <dwmw2@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org
In-Reply-To: <20060118223039.1d9dfe64.akpm@osdl.org>
References: <200601190052.k0J0qmKC009977@shell0.pdx.osdl.net>
	 <1137648119.30084.94.camel@localhost.localdomain>
	 <20060119171708.7f856b42.sfr@canb.auug.org.au>
	 <20060118223039.1d9dfe64.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 19 Jan 2006 17:40:08 +1100
Message-Id: <1137652808.30084.125.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-18 at 22:30 -0800, Andrew Morton wrote:
> So the lowest common denominator wins, because they hurt more than
> anyone else if we go outside 80-cols.  I use 80-col xterms precisely
> for this reason: so that the code which goes in will look OK to those
> users.

That would make some sense if it weren't for the fact that the snippet
of patch I just showed doesn't actually improve the situation for the
lowest common denominator -- it only makes it worse for the rest of us.

Put real meaningful stuff within 80 columns by all means -- but please
allow lines to be longer than that if they're just 'fluff'. 

-- 
dwmw2

