Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267126AbSLRCWQ>; Tue, 17 Dec 2002 21:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267129AbSLRCWQ>; Tue, 17 Dec 2002 21:22:16 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:49107 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S267126AbSLRCWP>;
	Tue, 17 Dec 2002 21:22:15 -0500
Date: Tue, 17 Dec 2002 18:29:59 -0800
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] : More module parameter compatibility for 2.5.52
Message-ID: <20021218022959.GA25958@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20021217173346.GA22924@bougret.hpl.hp.com> <20021218022816.E2EC52C2CE@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021218022816.E2EC52C2CE@lists.samba.org>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2002 at 01:24:57PM +1100, Rusty Russell wrote:
>
> I think you're confusing "param_array() doesn't handle 2d arrays" with
> "infrastructure not powerful enough".  Since __module_param_call() is
> functionally equivalent to __setup(), the second one seems unlikely.
> 
> Writing such an extension is a job for the next mail...
> 
> Does that clarify?

	Perfect.

> Rusty.

	Good luck...

	Jean
