Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289971AbSAWTFy>; Wed, 23 Jan 2002 14:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289973AbSAWTFo>; Wed, 23 Jan 2002 14:05:44 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:38924 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S289971AbSAWTFd>;
	Wed, 23 Jan 2002 14:05:33 -0500
Date: Wed, 23 Jan 2002 17:05:13 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Badari Pulavarty <badari@us.ibm.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH *] rmap VM, version 12
In-Reply-To: <OFB07135FF.E6C5BE7E-ON88256B4A.0068CB3F@boulder.ibm.com>
Message-ID: <Pine.LNX.4.33L.0201231704430.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2002, Badari Pulavarty wrote:

> Does this explain why my SMP box does not boot with rmap12 ? It works fine
> with rmap11c.
>
> Machine: 4x  500MHz Pentium Pro with 3GB RAM
>
> When I tried to boot 2.4.17+rmap12, last message I see is
>
> uncompressing linux ...
> booting ..

At this point we're not even near using pagetables yet,
so I guess this is something else ...

(I'm not 100% sure, though)

kind regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

