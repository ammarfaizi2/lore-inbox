Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751822AbWIGPRt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751822AbWIGPRt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 11:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751819AbWIGPRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 11:17:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32715 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751818AbWIGPRr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 11:17:47 -0400
Date: Thu, 7 Sep 2006 08:17:04 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Kirill Korotaev <dev@openvz.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Fernando Vazquez <fernando@oss.ntt.co.jp>,
       "David S. Miller" <davem@davemloft.net>, tony.luck@intel.com,
       linux-ia64@vger.kernel.org, stable@kernel.org, xemul@openvz.org,
       devel@openvz.org
Subject: Re: [PATCH] IA64,sparc: local DoS with corrupted ELFs
In-Reply-To: <44FFF1A0.2060907@openvz.org>
Message-ID: <Pine.LNX.4.64.0609070816170.27779@g5.osdl.org>
References: <44FC193C.4080205@openvz.org> <Pine.LNX.4.64.0609061120430.27779@g5.osdl.org>
 <44FFF1A0.2060907@openvz.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Sep 2006, Kirill Korotaev wrote:
> 
> Does the patch below looks better?

Yes. 

Apart from the whitespace corruption, that is.

I don't know how to get mozilla to not screw up whitespace.

		Linus
