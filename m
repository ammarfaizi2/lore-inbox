Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316770AbSHGB2K>; Tue, 6 Aug 2002 21:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316775AbSHGB2J>; Tue, 6 Aug 2002 21:28:09 -0400
Received: from holomorphy.com ([66.224.33.161]:44177 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316770AbSHGB2J>;
	Tue, 6 Aug 2002 21:28:09 -0400
Date: Tue, 6 Aug 2002 18:31:52 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: fix CONFIG_HIGHPTE
Message-ID: <20020807013152.GA15685@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rik van Riel <riel@conectiva.com.br>,
	Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
References: <3D506D43.890EA215@zip.com.au> <Pine.LNX.4.44L.0208062150290.23404-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0208062150290.23404-100000@imladris.surriel.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Aug 2002, Andrew Morton wrote:
>> Is it likely that large pages and/or shared pagetables would allow us to
>> place pagetables and pte_chains in the direct-mapped region, avoid all
>> this?

On Tue, Aug 06, 2002 at 09:50:50PM -0300, Rik van Riel wrote:
> For all workloads we care about, yes.
> regards,
> Rik

Not the university workload. NFI what my employer thinks of it, but I
care about it for the sake of correctness in all cases.

Lynch me now.


Cheers,
Bill
