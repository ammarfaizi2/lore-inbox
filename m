Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263501AbTCUHEn>; Fri, 21 Mar 2003 02:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263503AbTCUHEn>; Fri, 21 Mar 2003 02:04:43 -0500
Received: from holomorphy.com ([66.224.33.161]:21131 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S263501AbTCUHEm>;
	Fri, 21 Mar 2003 02:04:42 -0500
Date: Thu, 20 Mar 2003 23:15:26 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] anobjrmap 1/6 rmap.h
Message-ID: <20030321071526.GA30140@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, Hugh Dickins <hugh@veritas.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <Pine.LNX.4.44.0303202310440.2743-100000@localhost.localdomain> <20030320224813.0df5a911.akpm@digeo.com> <20030321070746.GF1350@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030321070746.GF1350@holomorphy.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 20, 2003 at 10:48:13PM -0800, Andrew Morton wrote:
>> This all needs to be redone with oprofile, find out what on earth is going
>> on.

On Thu, Mar 20, 2003 at 11:07:46PM -0800, William Lee Irwin III wrote:
> How about this?

These were profiles of kernel compiles on 16x/16GB NUMA-Q.

The profiles leave me more confused than when I started. Cache effects
are potentially responsible.


-- wli
