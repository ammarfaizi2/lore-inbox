Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263221AbUB1ApW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 19:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263224AbUB1ApW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 19:45:22 -0500
Received: from palrel13.hp.com ([156.153.255.238]:20669 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S263221AbUB1ApT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 19:45:19 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16447.58524.257563.252138@napali.hpl.hp.com>
Date: Fri, 27 Feb 2004 16:45:16 -0800
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: davidm@hpl.hp.com,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton OSDL <akpm@osdl.org>
Subject: Re: [patch] u64 casts
In-Reply-To: <1077920213.2233.44.camel@cube>
References: <1077915522.2255.28.camel@cube>
	<16447.56941.774257.925722@napali.hpl.hp.com>
	<1077920213.2233.44.camel@cube>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On 27 Feb 2004 17:16:53 -0500, Albert Cahalan <albert@users.sourceforge.net> said:

  Albert> Supposing that this is the case, you may get warnings.

Well, then do it on your own kernel/system.  I'm not interested in
spending time on this now, so please don't touch ia64 unless you
verified that all the other pieces are in place.

	--david
