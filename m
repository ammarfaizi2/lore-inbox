Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbUBUAmK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 19:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbUBUAmB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 19:42:01 -0500
Received: from gate.crashing.org ([63.228.1.57]:4012 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261459AbUBUAlH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 19:41:07 -0500
Subject: Re: Fix silly thinko in sungem network driver.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20040220163457.2ea387e5.davem@redhat.com>
References: <200402202307.i1KN7GBR003938@hera.kernel.org>
	 <1077321849.9719.32.camel@gaston> <1077322322.9623.34.camel@gaston>
	 <20040220162318.097006ee.davem@redhat.com>
	 <1077323090.10877.9.camel@gaston>
	 <20040220163457.2ea387e5.davem@redhat.com>
Content-Type: text/plain
Message-Id: <1077323725.11043.14.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 21 Feb 2004 11:35:27 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It just says that all Sun versions of GEM support the IBURST bit.
> 
> It seems clear to me that the current code in Linus's tree is correct
> and matches what Apple is doing.

Yes it does. it's a bad week for me apparently. I think most of
the patches I sent to linus lately had at least a typo, now that ...
pffff....

Ben.


