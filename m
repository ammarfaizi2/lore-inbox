Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131156AbQK2Wtj>; Wed, 29 Nov 2000 17:49:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131527AbQK2Wt3>; Wed, 29 Nov 2000 17:49:29 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:9468 "EHLO math.psu.edu")
        by vger.kernel.org with ESMTP id <S131156AbQK2WtV>;
        Wed, 29 Nov 2000 17:49:21 -0500
Date: Wed, 29 Nov 2000 17:18:49 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andries.Brouwer@cwi.nl
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, tigran@veritas.com
Subject: Re: corruption
In-Reply-To: <UTC200011292154.WAA150996.aeb@aak.cwi.nl>
Message-ID: <Pine.GSO.4.21.0011291716190.17068-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 29 Nov 2000 Andries.Brouwer@cwi.nl wrote:

> > ISTR bug reports looking like that and IIRC they were never resolved.
> 
> Have you looked at the report by Daniel Phillips?

Yes. The problem is real, but the fix... I'm doing a cleanup there and
I'll post the patch when I'll give it some testing.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
