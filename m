Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277820AbRJIQfC>; Tue, 9 Oct 2001 12:35:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277822AbRJIQew>; Tue, 9 Oct 2001 12:34:52 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:64196 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S277820AbRJIQel>;
	Tue, 9 Oct 2001 12:34:41 -0400
Date: Tue, 9 Oct 2001 09:35:10 -0700
To: "Randy.Dunlap" <rddunlap@osdlab.org>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Wireless Extension update
Message-ID: <20011009093510.C16176@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <20011008191247.B6816@bougret.hpl.hp.com> <3BC3243A.D3B48880@osdlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BC3243A.D3B48880@osdlab.org>; from rddunlap@osdlab.org on Tue, Oct 09, 2001 at 09:22:18AM -0700
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2001 at 09:22:18AM -0700, Randy.Dunlap wrote:
> Jean Tourrilhes wrote:
> > 
> >         Hi,
> 
> Hi-
> 
> > - * Version :   11      28.3.01
> > + * Version :   12      5.10.01
> 
> nitpicking, i'm sure, but:
> 
> 5.10.01 could have several meanings, usually depending
> on geographic location etc., and there is an ISO
> standard (8601) which says:
> 
>   The international standard date notation is 
>   YYYY-MM-DD
> 
> I'd prefer not to be confused by the '>' quoted notation
> above, although I don't mind the dots instead of hyphens.
> 
> ~Randy

	If it was visible to the user or other part of the kernel, I
would worry. Consider this string as a random arbitrary string (an
opaque data type) that has meaning only to the original developer.
	On the other hand, the version (12) is what matters...
	C'est la vie, ne se prenons pas trop au serieux... Ho meglio
da fare che di cambiare questa data...

	Ciao...

	Jean
