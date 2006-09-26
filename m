Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964838AbWIZVjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbWIZVjT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 17:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964842AbWIZVjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 17:39:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11916 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964838AbWIZVjR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 17:39:17 -0400
Date: Tue, 26 Sep 2006 14:39:11 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>
cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: x86/x86-64 merge for 2.6.19
In-Reply-To: <200609262323.10190.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0609261437410.3952@g5.osdl.org>
References: <200609261244.43863.ak@suse.de> <200609262226.09418.ak@suse.de>
 <Pine.LNX.4.64.0609261339050.3952@g5.osdl.org> <200609262323.10190.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 26 Sep 2006, Andi Kleen wrote:
> 
> I normally do the main bulk the two week merge window and only important
> stuff afterwards (usually two or three smaller merges with more stuff
> and then only critical bug fixes in small batches until release). 
> 
> You want merges more often or more spaced out?

That sounds fine, let's just see how this firms up. It's not like I've 
really had a lot of "rules" in general, and mostly the merges tend to 
eventually find a pattern that is just convenient for everybody.

		Linus "don't worry, be happy" Torvalds
