Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263185AbSITRN6>; Fri, 20 Sep 2002 13:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263211AbSITRN6>; Fri, 20 Sep 2002 13:13:58 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:17604 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S263185AbSITRN4>;
	Fri, 20 Sep 2002 13:13:56 -0400
Date: Fri, 20 Sep 2002 10:19:01 -0700
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: jt@hpl.hp.com, thunder@lightweight.ods.org, linux-kernel@vger.kernel.org
Subject: Re: FW: 2.5.34: IR __FUNCTION__ breakage
Message-ID: <20020920171901.GG8260@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <MNEMKBGMDIMHCBHPHLGPMEEDDDAA.dag@brattli.net> <20020920171314.GD8260@bougret.hpl.hp.com> <3D8B580D.9030009@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D8B580D.9030009@mandrakesoft.com>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2002 at 01:17:01PM -0400, Jeff Garzik wrote:
> 
> I fixed up a bunch of these __FUNCTION__ breakage, you can grab them 
> from 2.5.37 (just released)

	I'll catch up with my e-mail and I'll look at that.

> Also, specifically relating to varargs macros as described above, you 
> can certainly have a varargs macro with zero args, just look at C99 
> varargs macros...

	I remember that it didn't work. Ok, I'll try again.

> 	Jeff

	Have fun...

	Jean
