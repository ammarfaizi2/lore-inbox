Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbTEMNZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 09:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbTEMNZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 09:25:26 -0400
Received: from [194.151.80.102] ([194.151.80.102]:25141 "EHLO devwks01")
	by vger.kernel.org with ESMTP id S261204AbTEMNZZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 09:25:25 -0400
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: Stephan von Krawczynski <skraw@ithnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: What exactly does "supports Linux" mean?
Date: Tue, 13 May 2003 15:46:32 +0200
User-Agent: KMail/1.5.1
Cc: Linus Torvalds <torvalds@transmeta.com>
References: <20030513151630.75ad4028.skraw@ithnet.com>
In-Reply-To: <20030513151630.75ad4028.skraw@ithnet.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305131546.32963.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This leads to my simple question: how can one claim his product supports
> linux, if it does not work with a kernel.org kernel? Is there any paper or
> open statement from big L (hello btw ;-) available what you have to do to
> call yourself "supporting linux"?

What about the following: a vendor provides linux drivers for one of its
products (thanks!).  These drivers simply do not work with some of its
other products (all variants of the same basic product).  There are no
linux drivers for these other products.  All the products claim to be
supported under linux.  This "linux support" is explicitly stated on
each product's web-page whether it is really supported or not.

Duncan.
