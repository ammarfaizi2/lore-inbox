Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750943AbWDTN0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbWDTN0r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 09:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750942AbWDTN0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 09:26:47 -0400
Received: from ns2.suse.de ([195.135.220.15]:52922 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750941AbWDTN0q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 09:26:46 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] Re: [PATCH] [6/6] i386: Move CONFIG_DOUBLEFAULT into arch/i386 where it belongs.
Date: Thu, 20 Apr 2006 15:26:21 +0200
User-Agent: KMail/1.9.1
Cc: Adrian Bunk <bunk@stusta.de>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
References: <4444C0EA.mailKK411J5GA@suse.de> <20060418190839.3fa53a0f.rdunlap@xenotime.net> <20060420114946.GM25047@stusta.de>
In-Reply-To: <20060420114946.GM25047@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604201526.22318.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 20 April 2006 13:49, Adrian Bunk wrote:

> My main problem with his patch is still the way he did it - sending a 
> patch reverting a recently included patch with neither discussion before 
> the patch nor mentioning in the patch that it's a revert nor a Cc to the 
> people involved with the patch.

I just noticed a problem (bogus symbols in my x86-64 config) and fixed it. I normally 
don't look at which patch it introduced for such trivial changes.

-Andi
