Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263565AbTICQYY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 12:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263525AbTICQXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 12:23:46 -0400
Received: from palrel12.hp.com ([156.153.255.237]:64679 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S263980AbTICQVo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 12:21:44 -0400
Date: Wed, 3 Sep 2003 09:21:37 -0700
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: irda-users@lists.sourceforge.net, trivial@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MODULE_ALIAS for IRDA dongles
Message-ID: <20030903162137.GA29299@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20030903080444.6FE6B2C085@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030903080444.6FE6B2C085@lists.samba.org>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 03, 2003 at 05:49:36PM +1000, Rusty Russell wrote:
> Rather than hardcoded names in modprobe, modules can offer their own
> aliases (which are overridden by config files).
> 
> Here are the IRDA dongle ones.
> 
> Please apply,
> Rusty.

	Works for me (in case you want to send that direct), as long
as you fix the typo below. If you want, I'll send this patch via the
usual route.

> +MODULE_ALIAS("irda-ongle-2"); /* IRDA_ACTISYS_DONGLE */

	You need to nail that one (that's a french/english joke).

	Thanks !

	Jean
