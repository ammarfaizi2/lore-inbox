Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293224AbSCOTp6>; Fri, 15 Mar 2002 14:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293204AbSCOTps>; Fri, 15 Mar 2002 14:45:48 -0500
Received: from whiterose.net ([64.65.220.94]:60433 "HELO whiterose.net")
	by vger.kernel.org with SMTP id <S293224AbSCOTph>;
	Fri, 15 Mar 2002 14:45:37 -0500
Date: Fri, 15 Mar 2002 14:49:38 -0500 (EST)
From: M Sweger <mikesw@ns1.whiterose.net>
To: Ville Herva <vherva@niksula.hut.fi>
Cc: linux-kernel@vger.kernel.org, andre@linux-ide.org
Subject: Re: linux 2.2.21 pre3, pre4 and rc1 problems. (fwd)
In-Reply-To: <20020315145844.GK128921@niksula.cs.hut.fi>
Message-ID: <Pine.BSF.4.21.0203151447230.11909-100000@ns1.whiterose.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok! I downloaded it, and patched the kernel. Although I don't have a
160gig drive yet (was waiting for backport), the linux 2.2.21rc2 with
the pre2 ide patch (latest and greatest) booted ok and hasn't crashed.
I'll need to try it on a new 160 gig drive sometime.

Hmmm.  Hope consideration is given to back port this patch to 2.2.x.




On Fri, 15 Mar 2002, Ville Herva wrote:

> On Fri, Mar 15, 2002 at 02:50:37PM +0000, you [Alan Cox] wrote:
> > > Hopefully, linux 2.2.x will get the 160gig IDE patch that 2.4.x has.
> > 
> > Andre's 2.2 patch has been picked up and maintained (I forget by who). I
> > don't consider it ever a mainstream 2.2 candidate
> 
> I think you mean Krzysztof Oledzki (ole@ans.pl)
> 
> From: Krzysztof Oledzki (ole@ans.pl)
> Subject: ANNOUNCE - 2.4.x ide backport for 2.2.21pre2 kernel 
> 
> http://groups.google.com/groups?q=ANNOUNCE+-+2.4.x+ide+backport+for&hl=en&ie=ISO-8859-1&oe=ISO-8859-1&selm=linux.kernel.Pine.LNX.4.33.0201291654480.17318-100000%40dark.pcgames.pl&rnum=1
> 
> 
> BTW: I've heard rumours that some older ide chipsets support 48-bit
> addressing with a bios upgrade. HPT370 and Via 686B have been mentioned.
> 
> Highpoint windows driver readme:
> 
>   v2.1  11/15/2001
>           * Add 48bit LBA (Big Drive) support
> 
> But I'm not sure whether this means HPT370 or 372 only.
> 
> Is this possible and will it be possible to support that functionality in
> Linux?
> 
> 
> -- v --
> 
> v@iki.fi
> 

