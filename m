Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265924AbUBQAEt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 19:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265941AbUBQAEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 19:04:49 -0500
Received: from gate.crashing.org ([63.228.1.57]:53921 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265924AbUBQAEs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 19:04:48 -0500
Subject: Re: 2.6.3-rc3 radeonfb: Problems with new (and old) driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Eger <eger@theboonies.us>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0402161546460.30742@home.osdl.org>
References: <Pine.LNX.4.50L0.0402160411260.2959-100000@rosencrantz.theboonies.us>
	 <1076904084.12300.189.camel@gaston>
	 <Pine.LNX.4.58.0402160947080.30742@home.osdl.org>
	 <1076968236.3648.42.camel@gaston>
	 <Pine.LNX.4.58.0402161410430.30742@home.osdl.org>
	 <1076969892.3649.66.camel@gaston>
	 <Pine.LNX.4.58.0402161420390.30742@home.osdl.org>
	 <1076972267.3649.81.camel@gaston>
	 <Pine.LNX.4.58.0402161503490.30742@home.osdl.org>
	 <1076974304.1046.102.camel@gaston>
	 <Pine.LNX.4.58.0402161546460.30742@home.osdl.org>
Content-Type: text/plain
Message-Id: <1076976245.3648.114.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 17 Feb 2004 11:04:05 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Oh, there is no hurry with this. In fact, I'd rather take it slow than try 
> to make any big changes to something that _largely_ works but has problems 
> in some special cases.
> 
> In fact, I'd be happiest if the first step would be to just rename the
> interface and change the argument infrastructure, but actually keep all
> the behaviour "obviously the same". Bugs and all, if it comes to that. So
> I'd rather take several small steps (and let people use it for a while in
> between) than try to do everything. And yes, 2.6.3 is not even a target.

That's fine with me. 

Ben.


