Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262460AbTCRO6Q>; Tue, 18 Mar 2003 09:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262461AbTCRO6Q>; Tue, 18 Mar 2003 09:58:16 -0500
Received: from landfill.ihatent.com ([217.13.24.22]:42882 "EHLO
	mail.ihatent.com") by vger.kernel.org with ESMTP id <S262460AbTCRO5z>;
	Tue, 18 Mar 2003 09:57:55 -0500
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.65-mm1
References: <20030318031104.13fb34cc.akpm@digeo.com>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 18 Mar 2003 16:08:51 +0100
In-Reply-To: <20030318031104.13fb34cc.akpm@digeo.com>
Message-ID: <87adfs4sqk.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> writes:
>
> [SNIP]
>

I tried to get find what made 2.5.64-mm1 special that made my Radeon
card work, and had no luck in boiling down the differences more than
generally waving in the general direction "seems to be the PCI
updates". Nothing, up to and including 2.5.64-mm8, worked, but now
2.5.65-mm1 works like a charm and I'm on it now. I'll let you know if
it breaks again (or other breakage I find) :)

mvh,
A
-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
