Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270864AbTG1Tlq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 15:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270880AbTG1Tlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 15:41:46 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:899 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S270864AbTG1Tln (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 15:41:43 -0400
Date: Mon, 28 Jul 2003 20:41:27 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Jack Dennon <jdd@seasurf.net>, linux-kernel@vger.kernel.org
Subject: Re: The well-factored 386
Message-ID: <20030728194127.GA10673@mail.jlokier.co.uk>
References: <03072809023201.00228@linux24> <20030728093245.60e46186.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030728093245.60e46186.davem@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> He talks about his x86 emulator he wrote, and people complain to me
> all the time about his postings.
> 
> Nobody ever follows up to any of his postings, he's not even
> discussing anything, he's just showing how great he thinkgs
> his x86 emulator is.

I didn't realise he was talking about an x86 emulator.  I thought he
was analyzing real hardware.

The one thing that made it on-topic for me was his quiet suggestion
that "forreal" mode interrupts are faster, and that it might, perhaps,
be possible to modify a Linux kernel to run in that mode - to take
advantage of the faster interrupts.

-- Jamie
