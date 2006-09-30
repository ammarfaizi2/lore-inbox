Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbWI3Dx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWI3Dx5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 23:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbWI3Dx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 23:53:57 -0400
Received: from [198.99.130.12] ([198.99.130.12]:49110 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1750757AbWI3Dx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 23:53:56 -0400
Date: Fri, 29 Sep 2006 23:52:34 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ollie Wild <aaw@google.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, dhollis@davehollis.com,
       Jason Lunz <lunz@falooley.org>
Subject: Re: [PATCH 2/2] UML - Don't roll my own random MAC generator
Message-ID: <20060930035234.GB10307@ccure.user-mode-linux.org>
References: <200609281814.k8SIEsG8005226@ccure.user-mode-linux.org> <65dd6fd50609291518s129786fbt1739c80533d1a36@mail.google.com> <20060929153853.9bab3ca7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060929153853.9bab3ca7.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2006 at 03:38:53PM -0700, Andrew Morton wrote:
> ahem.  That must have had a lot of testing ;)

It did have some - just missed a patch refresh.

> Jeff, could we pleeeeeze arrange for UML's `make allmodconfig' to work, and
> to continue to work?

It works for me - I haven't built -mm2 on x86_64 yet, but I'll check that.

				Jeff
