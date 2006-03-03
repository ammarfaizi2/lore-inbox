Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751382AbWCCTDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbWCCTDY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 14:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbWCCTDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 14:03:24 -0500
Received: from smtp-1.llnl.gov ([128.115.3.81]:29913 "EHLO smtp-1.llnl.gov")
	by vger.kernel.org with ESMTP id S1751382AbWCCTDX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 14:03:23 -0500
From: Dave Peterson <dsp@llnl.gov>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 10/15] EDAC: edac_mc_add_mc() fix [1/2]
Date: Fri, 3 Mar 2006 11:03:08 -0800
User-Agent: KMail/1.5.3
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       bluesmoke-devel@lists.sourceforge.net
References: <200603021748.07381.dsp@llnl.gov> <20060302183143.6730d255.akpm@osdl.org>
In-Reply-To: <20060302183143.6730d255.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603031103.08105.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 March 2006 18:31, Andrew Morton wrote:
> Dave Peterson <dsp@llnl.gov> wrote:
> >  This is part 1 of a 2-part patch set.  The code changes are split into
> >  two parts to make the patches more readable.
>
> Will the code compile and run with just #1-of-2 applied?

It should compile.  Assuming that it does, would it still have been
preferable to just combine the two into a single patch?
