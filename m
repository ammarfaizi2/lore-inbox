Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318257AbSIKAgf>; Tue, 10 Sep 2002 20:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318258AbSIKAge>; Tue, 10 Sep 2002 20:36:34 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:41975 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S318257AbSIKAfz>;
	Tue, 10 Sep 2002 20:35:55 -0400
Date: Tue, 10 Sep 2002 17:40:24 -0700
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Adrian Bunk <bunk@fs.tum.de>
Subject: Re: Linux 2.4.20-pre6
Message-ID: <20020911004024.GA30708@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20020910231424.GA30612@bougret.hpl.hp.com> <1031704911.2726.10.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1031704911.2726.10.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2002 at 01:41:51AM +0100, Alan Cox wrote:
> 
> > 	So, as people like quick'n'dirty hacks, just make sure that
> > TIOCM_MODEM_BITS is also defined in ARM, SH, PPC and Alpha (at least),
> > just to make sure I'm the only one complaining.
> 
> They are in my tree.

	Perfect, if all architectures are covered, I'm perfectly fine
with it. Sorry for having ranted too fast ;-)

	Jean
