Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbUBJVuC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 16:50:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbUBJVuC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 16:50:02 -0500
Received: from shiva.warpcore.org ([216.81.249.60]:30697 "EHLO
	shiva.warpcore.org") by vger.kernel.org with ESMTP id S261567AbUBJVt7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 16:49:59 -0500
Subject: Re: Kernel GPL Violations and How to Research
From: Gidon <gidon@warpcore.org>
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040210192007.GA6987@one-eyed-alien.net>
References: <1076388828.9259.32.camel@CPE-65-26-89-23.kc.rr.com>
	 <20040210192007.GA6987@one-eyed-alien.net>
Content-Type: text/plain
Message-Id: <1076449796.6373.3.camel@CPE-65-26-89-23.kc.rr.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 10 Feb 2004 15:49:56 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-02-10 at 13:20, Matthew Dharm wrote:
> As a final level of analysis, you can always look at the compiled binary
> code -- if you think they are using a _reasonably_ compatible compiler, you
> might actually be able to find long sections of identical or near-identical
> assembly (modulo loop unrolling, etc. which you should be able to identify
> by hand.)

Your advice is appreciated. I will do some further research using
objdump. I believe they use gcc.

One thing I am unsure of is how to approach them and ensure at the same
time that the problem is taken care of. Another words, if I show them
what's wrong, they may simply obfuscate it (although at this time I hope
not) and then I have no way to easily prove anything anymore...

-- 
I am subscribed to this mailing list. It is not necessary to CC me.
Thank you. -Gidon

