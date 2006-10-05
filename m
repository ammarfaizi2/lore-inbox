Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbWJEURq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbWJEURq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 16:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbWJEURq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 16:17:46 -0400
Received: from ns.suse.de ([195.135.220.2]:40082 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751213AbWJEURq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 16:17:46 -0400
From: Andi Kleen <ak@suse.de>
To: Steve Bergman <sbergman@rueb.com>
Subject: Re: Free memory level in 2.6.16?
Date: Thu, 5 Oct 2006 22:17:38 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <1160034527.23009.7.camel@localhost> <p73k63ezg3y.fsf@verdi.suse.de> <1160079029.29452.19.camel@localhost>
In-Reply-To: <1160079029.29452.19.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610052217.38345.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Thank you for the reply, Andi.  This kernel is compiled with the .config
> from the original FC5 release, which used kernel 2.6.15.  I just ran
> "make oldconfig" on it and accepted the defaults.

I meant in the source. There are no tunables for this in
.config
 
> So it is, I believe, a 4GB/4GB split.  Does that make a difference?

The kernel.org kernel doesn't support 4/4 split.

-Andi
