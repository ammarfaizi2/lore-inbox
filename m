Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752018AbWJWV1Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018AbWJWV1Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 17:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752019AbWJWV1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 17:27:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16864 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752018AbWJWV1P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 17:27:15 -0400
Date: Mon, 23 Oct 2006 14:27:02 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: David Miller <davem@davemloft.net>
cc: ctpm@ist.utl.pt, linux-kernel@vger.kernel.org
Subject: Re: Unintended commit?
In-Reply-To: <20061023.141040.59654407.davem@davemloft.net>
Message-ID: <Pine.LNX.4.64.0610231425550.3962@g5.osdl.org>
References: <200610231809.09238.ctpm@ist.utl.pt> <Pine.LNX.4.64.0610231013340.3962@g5.osdl.org>
 <20061023.141040.59654407.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 23 Oct 2006, David Miller wrote:
> 
> I accidently commited it, again sorry.  Greg KH has a patch coming to
> you soon which will move that VGA code back into x86/x86_64/IA64
> specific areas and will fix the sparc64 problem properly.

Ok. I reverted that part, we'll get it sorted out properly with Greg's 
patches.

Claudio, thanks for noticing!

		Linus
