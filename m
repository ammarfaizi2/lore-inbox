Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261693AbUD3CZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbUD3CZH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 22:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265044AbUD3CYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 22:24:45 -0400
Received: from holomorphy.com ([207.189.100.168]:59520 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265043AbUD3CYf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 22:24:35 -0400
Date: Thu, 29 Apr 2004 19:24:32 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc2-mm2
Message-ID: <20040430022432.GC996@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	James Bottomley <James.Bottomley@steeleye.com>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20040426013944.49a105a8.akpm@osdl.org> <20040429184126.GB783@holomorphy.com> <20040429134546.5e9515d8.akpm@osdl.org> <20040429211825.GC783@holomorphy.com> <20040430002455.GA996@holomorphy.com> <1083290708.1804.191.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1083290708.1804.191.camel@mulgrave>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-29 at 19:24, William Lee Irwin III wrote:
>> # ChangeSet
>> #   2004/04/25 09:10:30-05:00 akpm@osdl.org 
>> #   [PATCH] aic7xxx: fix oops whe hardware is not present
>> #   From: Herbert Xu <herbert@gondor.apana.org.au>

On Thu, Apr 29, 2004 at 09:05:06PM -0500, James Bottomley wrote:
> OK, well, on inspection that patch is fairly comprehensively incorrect.
> Can you try out the attached?  I've compiled it but have nothing to test
> installation with.

I'll give it a whirl. I've got a slow turnaround time (>= 1hr) for the
moment, so please be patient.


-- wli
