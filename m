Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262960AbTCSKFx>; Wed, 19 Mar 2003 05:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262978AbTCSKFx>; Wed, 19 Mar 2003 05:05:53 -0500
Received: from landfill.ihatent.com ([217.13.24.22]:10627 "EHLO
	mail.ihatent.com") by vger.kernel.org with ESMTP id <S262960AbTCSKFw>;
	Wed, 19 Mar 2003 05:05:52 -0500
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.65-mm2
References: <20030319012115.466970fd.akpm@digeo.com>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 19 Mar 2003 11:16:51 +0100
In-Reply-To: <20030319012115.466970fd.akpm@digeo.com>
Message-ID: <87el53acfg.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> writes:
>
> [SNIP]
>

Yay! Still working Radeon :)

And 4x AGP:

agpgart: Putting AGP V2 device at 00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 01:00.0 into 4x mode

Come to think of it, I'll give it a spin, this might be due to a
working DSDT table that was compiled in with ACPI, whereas I had the
1x problems before I did this.

mvh,
A
-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
