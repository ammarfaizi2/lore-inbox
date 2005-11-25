Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751438AbVKYKqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbVKYKqn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 05:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbVKYKqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 05:46:42 -0500
Received: from mail22.syd.optusnet.com.au ([211.29.133.160]:11140 "EHLO
	mail22.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751438AbVKYKqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 05:46:42 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: Kernel BUG at mm/rmap.c:491
Date: Fri, 25 Nov 2005 21:45:34 +1100
User-Agent: KMail/1.8.3
Cc: Keith Owens <kaos@ocs.com.au>, Dave Jones <davej@redhat.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Kenneth W <kenneth.w.chen@intel.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
References: <25093.1132876061@ocs3.ocs.com.au> <200511251050.02833.kernel@kolivas.org> <Pine.LNX.4.61.0511251040460.5479@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0511251040460.5479@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511252145.35342.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Nov 2005 21:43, Hugh Dickins wrote:
> On Fri, 25 Nov 2005, Con Kolivas wrote:
> > Would anyone object to changing it so that tainted only means Proprietary
> > taint and use a different keyword for GPL tainting such as "Corrupted"?
>
> I don't see the point.  The system is in a dubious state, tainted is
> the word we've been using for that, the flags indicate what's suspect,
> why play with the wording further?

I was simply thinking of us confused users. No good reason otherwise.

Cheers,
Con
