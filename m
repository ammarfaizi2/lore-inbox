Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262998AbVCDT4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262998AbVCDT4n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 14:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262952AbVCDTsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 14:48:50 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:12462 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S263003AbVCDTfT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 14:35:19 -0500
Message-ID: <4228B868.7010104@dgreaves.com>
Date: Fri, 04 Mar 2005 19:35:04 +0000
From: David Greaves <david@dgreaves.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       davej@redhat.com, torvalds@osdl.org, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <20050302230634.A29815@flint.arm.linux.org.uk> <42265023.20804@pobox.com> <Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org> <20050303002733.GH10124@redhat.com> <20050302203812.092f80a0.akpm@osdl.org> <20050304105247.B3932@flint.arm.linux.org.uk> <20050304032632.0a729d11.akpm@osdl.org> <20050304113626.E3932@flint.arm.linux.org.uk> <01ef01c520b7$94bebf80$0f01a8c0@max> <20050304132535.A9133@flint.arm.linux.org.uk> <039001c520e0$4ea3fbe0$0f01a8c0@max>
In-Reply-To: <039001c520e0$4ea3fbe0$0f01a8c0@max>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Purdie wrote:

> Writing instructions for setting up oe to build it may be the best 
> option.

As it happens I was editing that exact page in the wiki t'other day:
  http://openembedded.org/cgi-bin/moin.cgi/GettingStarted

I actually only wanted a toolchain but oe and scratchbox[1] seemed the 
rational alternatives.
Scratchbox seems to offer : arm-gcc-3.3.4-glibc-2.3.2 but I've not 
gotten round to using it yet.

Thanks for the comment on "bitbake binutils-cross-sdk" and "bitbake 
gcc-cross-sdk".
I'll add more notes to the page once I figure it all out.

David

[1] http://www.scratchbox.org/download/scratchbox-1.0/
