Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261269AbVCNElK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbVCNElK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 23:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbVCNElK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 23:41:10 -0500
Received: from zeus.kernel.org ([204.152.189.113]:60034 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261269AbVCNElG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 23:41:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=APWRQAud81Lw3kplA7xH0n/dHjzKo2dE0Cz68rNI7kRipVtf+v0KyO4xYz5KRG1c/fyGNBMpgn2cC0oP+8jk2bdy9oCSlq+Jt8R1jtu6Lzj3SvlQa1qT1QoLeUB+lK5pIqog3EetlFbHGk+wWbBfqwyEsKOe+ez+hIttfG6alh4=
Message-ID: <5304685705031320129bfd9b0@mail.gmail.com>
Date: Sun, 13 Mar 2005 21:12:59 -0700
From: Jesse Allen <the3dfxdude@gmail.com>
Reply-To: Jesse Allen <the3dfxdude@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: More trouble with i386 EFLAGS and ptrace
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> > Once we're sure about the i386 state, we should update the x86_64 code to match.
>
> I have it fixed in my tree, but not pushed out yet because of lack of testing.

Andi,

I have someone who thinks they might be experiencing the same problem
that I reported but now on x86-64.  Could I get the patches from your
tree so they can be tested?

Jesse
