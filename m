Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129586AbRBTHWD>; Tue, 20 Feb 2001 02:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129807AbRBTHVo>; Tue, 20 Feb 2001 02:21:44 -0500
Received: from inspiron.swusa.com ([207.214.125.61]:7561 "HELO saw.sw.com.sg")
	by vger.kernel.org with SMTP id <S129586AbRBTHV3>;
	Tue, 20 Feb 2001 02:21:29 -0500
Message-ID: <20010219232136.C26553@saw.sw.com.sg>
Date: Mon, 19 Feb 2001 23:21:36 -0800
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: vido@ldh.org, Ion Badulescu <ionut@cs.columbia.edu>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: eepro100.c, kernel 2.4.1
In-Reply-To: <20010212133248.A7147@saw.sw.com.sg> <Pine.LNX.4.30.0102120048160.4687-100000@age.cs.columbia.edu> <20010220153048.A26551@ldh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <20010220153048.A26551@ldh.org>; from "Augustin Vidovic" on Tue, Feb 20, 2001 at 03:30:48PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2001 at 03:30:48PM +0900, Augustin Vidovic wrote:
> On Mon, Feb 12, 2001 at 01:00:34AM -0800, Ion Badulescu wrote:
> > > Augustin, could you send the output of `lspci' and `eepro100-diag -ee', please?
> > > (The latter may be taken from ftp://scyld.com/pub/diag/)
> > 
> > I'd be curious to see them too.
> 
> Ok, here is the output (the status are displayed only if the interface
> is down, so I had to go execute this manually on the machines) :
> 
> 
> eepro100-diag.c:v2.02 7/19/2000 Donald Becker (becker@scyld.com)
>  http://www.scyld.com/diag/index.html
> Index #1: Found a Intel i82557 (or i82558) EtherExpressPro100B adapter at 0xef00.
[snip]

What about lspci?

	Andrey
