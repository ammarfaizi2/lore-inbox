Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268791AbUJEFQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268791AbUJEFQq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 01:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268800AbUJEFQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 01:16:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:56031 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268791AbUJEFPz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 01:15:55 -0400
Date: Mon, 4 Oct 2004 22:15:44 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andy Lutomirski <luto@myrealbox.com>
cc: Andi Kleen <ak@muc.de>, Florian Bohrer <Florian.Bohrer@t-online.de>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: [PATCH] AES x86-64-asm impl.
In-Reply-To: <4161EC43.3070907@myrealbox.com>
Message-ID: <Pine.LNX.4.58.0410042214540.8290@ppc970.osdl.org>
References: <2KWl4-wq-25@gated-at.bofh.it> <m3acv4zz5f.fsf@averell.firstfloor.org>
 <41613937.8BF0FE0D@users.sourceforge.net> <20041004130839.GA9075@muc.de>
 <4161EC43.3070907@myrealbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 4 Oct 2004, Andy Lutomirski wrote:
> 
> WHAT?  We're dropping potentially better code because someone _who 
> didn't submit it_ disagrees for personal political reasons?  (Jari- I'm 
> not questioning your reasons for not wanting to be involved in 
> cryptoapi, but IIRC you did release that code under the GPL.)

Guys. Please remember this: don't bother with code that Jari supposedly 
"releases". It's simply not worth the bother.

		Linus
