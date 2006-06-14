Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964897AbWFNFyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964897AbWFNFyL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 01:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964896AbWFNFyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 01:54:11 -0400
Received: from cantor2.suse.de ([195.135.220.15]:49092 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964897AbWFNFyJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 01:54:09 -0400
From: Andi Kleen <ak@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: zoned vm counters: per zone counter functionality
Date: Wed, 14 Jun 2006 07:53:51 +0200
User-Agent: KMail/1.9.3
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, Con Kolivas <kernel@kolivas.org>,
       Marcelo Tosatti <marcelo@kvack.org>, linux-mm@kvack.org,
       Dave Chinner <dgc@sgi.com>
References: <20060612211244.20862.41106.sendpatchset@schroedinger.engr.sgi.com> <448F64A0.9090705@yahoo.com.au> <Pine.LNX.4.64.0606140636130.780@blonde.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.64.0606140636130.780@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606140753.51092.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 June 2006 07:37, Hugh Dickins wrote:
> On Wed, 14 Jun 2006, Nick Piggin wrote:
> > 
> > Hmm, then NR_ANON would become VM_ZONE_STAT_NR_ANON? That might be a bit
> > long for your tastes, maybe the prefix could be hidden by "clever" macros?
> 
> Don't even begin to think of "clever" macros.

Yes they cause cancer of the grep. SCNR.

-Andi
