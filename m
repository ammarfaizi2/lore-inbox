Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136591AbREGSdT>; Mon, 7 May 2001 14:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136581AbREGSdJ>; Mon, 7 May 2001 14:33:09 -0400
Received: from ns.snowman.net ([63.80.4.34]:25607 "EHLO ns.snowman.net")
	by vger.kernel.org with ESMTP id <S136577AbREGSc6>;
	Mon, 7 May 2001 14:32:58 -0400
Date: Mon, 7 May 2001 14:30:28 -0400 (EDT)
From: <nick@snowman.net>
To: Dan Hollis <goemon@anime.net>
cc: Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>,
        "Bene, Martin" <Martin.Bene@KPNQwest.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: what causes Machine Check exception? revisited (2.2.18)
In-Reply-To: <Pine.LNX.4.30.0105071122290.5820-100000@anime.net>
Message-ID: <Pine.LNX.4.21.0105071429560.9994-100000@ns>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yep, totally.  I've worked on hundreds of systems and less than 20 of the
workstations or PCs have been useing ECC.  Most servers do, but not even
all of them.
	Nick

On Mon, 7 May 2001, Dan Hollis wrote:

> On Mon, 7 May 2001, Simon Richter wrote:
> > On Mon, 7 May 2001, Bene, Martin wrote:
> > > Definitely not caused by:
> > > 	Bad Rams, mb-chipset.
> > Erm, it was bad RAM everytime it happened to me. On standard PCs, you
> > don't see those because you don't have ECC and the error is simply not
> > detected.
> 
> So a 440bx motherboard with ECC ram is a non-standard PC?
> 
> -Dan
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

