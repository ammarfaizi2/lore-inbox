Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261670AbVA3LC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbVA3LC5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 06:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261676AbVA3LC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 06:02:57 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:31627 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261670AbVA3LCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 06:02:55 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Nelson <evildarkarchon@gmail.com>
Subject: Re: 2.6.11-rc2-mm2
Date: Sun, 30 Jan 2005 12:03:12 +0100
User-Agent: KMail/1.7.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050129131134.75dacb41.akpm@osdl.org> <891493700501292220216e4186@mail.gmail.com>
In-Reply-To: <891493700501292220216e4186@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501301203.13240.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 30 of January 2005 07:20, Andrew Nelson wrote:
> I got a compile error:
> arch/x86_64/kernel/asm-offsets.c: In function `main':
> arch/x86_64/kernel/asm-offsets.c:65: error: invalid application of
> `sizeof' to incomplete type `pbe'
> arch/x86_64/kernel/asm-offsets.c:66: error: dereferencing pointer to
> incomplete type
> arch/x86_64/kernel/asm-offsets.c:67: error: dereferencing pointer to
> incomplete type
> make[1]: *** [arch/x86_64/kernel/asm-offsets.s] Error 1
> make: *** [arch/x86_64/kernel/asm-offsets.s] Error 2

I don't see it.  Have you started from a fresh tree?

Greets,
RJW


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
