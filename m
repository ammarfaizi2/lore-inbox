Return-Path: <linux-kernel-owner+w=401wt.eu-S1422840AbWLUH7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422840AbWLUH7I (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 02:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422836AbWLUH7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 02:59:08 -0500
Received: from smtp.osdl.org ([65.172.181.25]:47093 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422833AbWLUH7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 02:59:04 -0500
Date: Wed, 20 Dec 2006 23:58:30 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Len Brown <lenb@kernel.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, linux-acpi@vger.kernel.org
Subject: Re: [GIT PATCH] ACPI patches for 2.6.20-rc1
In-Reply-To: <200612200434.56516.lenb@kernel.org>
Message-ID: <Pine.LNX.4.64.0612202357110.3576@woody.osdl.org>
References: <200612200434.56516.lenb@kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 20 Dec 2006, Len Brown wrote:
> 
> please pull from: 

Is this really all obvious bug-fixes? There seems to be a lot of 
development there that simply isn't appropriate after an -rc1 any more.

I want 2.6.20 to be stable, and one of the things I'm doing is to be 
strict about the merge window.

		Linus
