Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266836AbUHISeB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266836AbUHISeB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 14:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266855AbUHISdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 14:33:35 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:18862 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266836AbUHISct (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 14:32:49 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.8-rc3-mm2
Date: Mon, 9 Aug 2004 11:32:39 -0700
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>
References: <20040808152936.1ce2eab8.akpm@osdl.org> <200408091122.48492.jbarnes@engr.sgi.com> <20040809112550.2ea19dbf.akpm@osdl.org>
In-Reply-To: <20040809112550.2ea19dbf.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408091132.39752.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, August 9, 2004 11:25 am, Andrew Morton wrote:
> I had the same hang on my ia64 test box, once.  But during the
> binary-search-through-patches process it disappeared.  Try booting again :(

I've tried a few times now, 100% failure rate.

> I'd be suspecting one of the CPU scheduler patches.

Yep, that's what I'm looking at now...

Thanks,
Jesse
