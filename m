Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266056AbTIJXrf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 19:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266057AbTIJXrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 19:47:35 -0400
Received: from palrel11.hp.com ([156.153.255.246]:9705 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S266056AbTIJXre (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 19:47:34 -0400
Date: Wed, 10 Sep 2003 16:47:28 -0700
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Max Krasnyansky <maxk@qualcomm.com>,
       BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] BlueTooth socket busted in 2.6.0-test5
Message-ID: <20030910234728.GA8051@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20030910225810.GA7712@bougret.hpl.hp.com> <1063237174.28890.6.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1063237174.28890.6.camel@pegasus>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 11, 2003 at 01:39:28AM +0200, Marcel Holtmann wrote:
> Hi Jean,
> 
> yesterday David Woodhouse sent a patch which should fix this.
> 
> Regards
> 
> Marcel

	Yep that seems to have fixed the problem.
	Thanks a lot !

	Jean
