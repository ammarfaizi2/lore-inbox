Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266174AbUGJHAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266174AbUGJHAz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 03:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266175AbUGJHAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 03:00:55 -0400
Received: from mail-relay-4.tiscali.it ([212.123.84.94]:35539 "EHLO
	sparkfist.tiscali.it") by vger.kernel.org with ESMTP
	id S266174AbUGJHAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 03:00:50 -0400
Date: Sat, 10 Jul 2004 08:59:43 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Chris Wright <chrisw@osdl.org>,
       akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       sds@epoch.ncsc.mil, jmorris@redhat.com, mika@osdl.org
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
Message-ID: <20040710065943.GF20947@dualathlon.random>
References: <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au> <Pine.LNX.4.53.0407080707010.21439@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0407080707010.21439@chaos>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2004 at 07:10:12AM -0400, Richard B. Johnson wrote:
> Because NULL is a valid pointer value. 0 is not. If you were

ah you're doing my same mistake! ;) Just read the email I just posted on
this thread.
