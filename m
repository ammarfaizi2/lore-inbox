Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbTLUUBy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 15:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263765AbTLUUBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 15:01:54 -0500
Received: from gprs214-121.eurotel.cz ([160.218.214.121]:62081 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262714AbTLUUBw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 15:01:52 -0500
Date: Sun, 21 Dec 2003 21:02:57 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Larry McVoy <lm@work.bitmover.com>, linux-kernel@vger.kernel.org,
       bitkeeper-users@bitmover.com
Subject: Re: RFC - tarball/patch server in BitKeeper
Message-ID: <20031221200257.GA15772@elf.ucw.cz>
References: <20031214172156.GA16554@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031214172156.GA16554@work.bitmover.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> and patches.  The idea is to make it possible for all trees hosted by
> bkbits.net provide access to the data with a free client (included
					       ~~~~
> below
> in prototype form).

Unfortunately that is not free client for any reasonable definition of
"free"; which matters, because it means that tarball.c is not getting
into any distribution in any form. Someone will simply have to
reimplement it.
								Pavel

> /*
>  * tarball.c copyright (c) 2003 BitMover, Inc.
>  *
>  * Licensed under the NWL - No Whining License.
>  *
>  * You may use this, modify this, redistribute this provided you agree:
>  * - not to whine about this product or any other products from BitMover, Inc.
>  * - that there is no warranty of any kind.
>  * - retain this copyright in full.
>  */

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
