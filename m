Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316548AbSEUIaN>; Tue, 21 May 2002 04:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316562AbSEUIaM>; Tue, 21 May 2002 04:30:12 -0400
Received: from 217-79-104-247.adsl.griffin.net.uk ([217.79.104.247]:3112 "EHLO
	lemur.beezly.org.uk") by vger.kernel.org with ESMTP
	id <S316548AbSEUIaM>; Tue, 21 May 2002 04:30:12 -0400
Date: Tue, 21 May 2002 09:30:04 +0100
To: "David S. Miller" <davem@redhat.com>
Cc: hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: OOPS: ext3/sparc badness
Message-ID: <20020521083004.GB18501@monkey.beezly.org.uk>
In-Reply-To: <1021897921.8474.8.camel@montgomery> <20020520.143018.82222608.davem@redhat.com> <20020520225206.A15153@infradead.org> <20020520.150628.25332319.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Andrew Beresford <beezly@beezly.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David,

On Mon, May 20, 2002 at 03:06:28PM -0700, David S. Miller wrote:
>    From: Christoph Hellwig <hch@infradead.org>
>    Date: Mon, 20 May 2002 22:52:06 +0100
> 
>    On Mon, May 20, 2002 at 02:30:18PM -0700, David S. Miller wrote:
>    > Unsupported compiler for sparc64 kernels.  Your OOPS report is going
>    > to be ignored.

Understood, but the reason I was using 3.0.4 was because sparc64-egcs
has been suspected of generating some bad code in the md.c (see the link
in the previous e-mail I sent).

>    Btw, is gcc 3.1 supported now or only the magic egcs variant?
>    
> gcc-3.1 should work properly, I've used it but I'm hesitant to %100
> bless it just yet. :-)
> 
> I would prefer to receive bug reports only against the sparc64-egcs
> compiler still.

I will give gcc-3.1 a try.

Cheers,

Beezly
