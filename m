Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315721AbSHFVsM>; Tue, 6 Aug 2002 17:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315748AbSHFVsM>; Tue, 6 Aug 2002 17:48:12 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:6641 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S315721AbSHFVsL>;
	Tue, 6 Aug 2002 17:48:11 -0400
Date: Tue, 6 Aug 2002 14:51:48 -0700
To: Greg KH <greg@kroah.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Jeff Garzik <jgarzik@mandrakesoft.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4] : ir240_usb_disconnect-2.diff
Message-ID: <20020806215148.GE11884@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20020806205251.GF11677@bougret.hpl.hp.com> <20020806214334.GA2393@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020806214334.GA2393@kroah.com>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2002 at 02:43:35PM -0700, Greg KH wrote:
> On Tue, Aug 06, 2002 at 01:52:51PM -0700, Jean Tourrilhes wrote:
> >  	purb_t purb;
> 
> I've gotten rid of this stupid typedef in Marcelo's latest kernel, so
> this patch will probably not apply.
> 
> Sorry about this.  If it's a big problem, I'll do the merge for you.
> 
> thanks,
> 
> greg k-h

	It must be my day ;-) I'll deal with that (because I'm the one
doing the testing).

	Jean
