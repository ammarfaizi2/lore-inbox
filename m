Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751295AbVJaCw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbVJaCw6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 21:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbVJaCw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 21:52:58 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:24809
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1751295AbVJaCw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 21:52:57 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
Subject: Re: [git patches] 2.6.x libata updates
Date: Sun, 30 Oct 2005 20:52:53 -0600
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <20051029182228.GA14495@havoc.gtf.org> <200510301731.47825.rob@landley.net> <Pine.LNX.4.64.0510301654310.27915@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510301654310.27915@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: "Undisclosed.Recipients":;
Message-Id: <200510302052.53679.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 October 2005 18:58, Linus Torvalds wrote:
> Using "git bisect" to generate successive bisections (and then building up
> a linearization patch from that) would work,

I don't suppose I could make puppy eyes at somebody _else_ to bang on git a 
bit and try to come up with a proof-of-concept patch?  (Say 
2.6.14-rc5-bisect.patch?)

I just downloaded the git source snapshot to find out it won't compile without 
openssl headers.  (Thanks, ubuntu, for stripping out every darn development 
header and making them separate things you have to hunt down and install 
individually, even though the box actually _has_ whatever darn library it's 
complaining about and really couldn't _function_ without it.  Sigh.)

Rob

(kynaptic 
--install-the-development-headers-for-all-installed-packages-already)
