Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315379AbSEVOiK>; Wed, 22 May 2002 10:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315372AbSEVOiJ>; Wed, 22 May 2002 10:38:09 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:27600 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S315358AbSEVOiH>;
	Wed, 22 May 2002 10:38:07 -0400
Date: Wed, 22 May 2002 10:38:07 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: jack@suse.cz, Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.17
In-Reply-To: <3CEB9826.4070000@evision-ventures.com>
Message-ID: <Pine.GSO.4.21.0205221035150.2737-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 22 May 2002, Martin Dalecki wrote:

> 2. Typical string formating and value copy and termination
>      problems inherent to string stuff...

s/inherent to/inherent to incompetently written/

BTW, quoted code should've used seq_file helpers - that would both
cut the code size way down and fix the damn thing.

