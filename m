Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751084AbVJCPJm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbVJCPJm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 11:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbVJCPJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 11:09:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15029 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751084AbVJCPJl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 11:09:41 -0400
Date: Mon, 3 Oct 2005 08:06:24 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Jackson <pj@sgi.com>
cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org,
       Pete Zaitcev <zaitcev@redhat.com>, Coywolf Qi Hunt <coywolf@gmail.com>,
       Greg KH <greg@kroah.com>
Subject: Re: [PATCH] Document patch subject line better
In-Reply-To: <20051003072910.14726.10100.sendpatchset@jackhammer.engr.sgi.com>
Message-ID: <Pine.LNX.4.64.0510030805380.31407@g5.osdl.org>
References: <20051003072910.14726.10100.sendpatchset@jackhammer.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 3 Oct 2005, Paul Jackson wrote:
>
> Improve explanation of the Subject line fields in
> Documentation/SubmittingPatches Canonical Patch Format.

Ironically, the patch you sent doesn't adhere to the very documentation 
you are updating ;)

Hint: missing "---".

		Linus
