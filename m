Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbUEFHrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbUEFHrx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 03:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbUEFHrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 03:47:53 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:8720 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261181AbUEFHrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 03:47:52 -0400
Date: Thu, 6 May 2004 08:47:43 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andi Kleen <ak@muc.de>
Cc: "R. J. Wysocki" <rjwysocki@sisk.pl>, Andrew Morton <akpm@zip.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3-mm2 does not build on AMD64 + essential patch is missing
Message-ID: <20040506084743.A12990@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andi Kleen <ak@muc.de>, "R. J. Wysocki" <rjwysocki@sisk.pl>,
	Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
References: <200405052210.18074.rjwysocki@sisk.pl> <20040506074302.GA47323@colin2.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040506074302.GA47323@colin2.muc.de>; from ak@muc.de on Thu, May 06, 2004 at 09:43:02AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2004 at 09:43:02AM +0200, Andi Kleen wrote:
> Just revert the broken small-numa-api-fixups.patch patch,
> which never seems to have been compile tested on anything.

compiles fine on ppc32 and x86.

