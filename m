Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263291AbUCRXsb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 18:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263306AbUCRXrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 18:47:51 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:49283
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263322AbUCRX2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 18:28:14 -0500
Date: Fri, 19 Mar 2004 00:29:04 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc1-aa1
Message-ID: <20040318232904.GD2050@dualathlon.random>
References: <20040318022201.GE2113@dualathlon.random> <Pine.LNX.4.44.0403181928210.16385-100000@localhost.localdomain> <20040318230628.GA2050@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040318230628.GA2050@dualathlon.random>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2004 at 12:06:28AM +0100, Andrea Arcangeli wrote:
> Ok, I don't think it's the right way to go but you quite convinced me on
> this for the short term (now that it swaps heavily just fine and I'm not

sorry, I changed my mind again, using the cast is too ugly, I don't like
it, so I'm going to apply your fs fixes instead ;)
