Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129830AbQJ3X1N>; Mon, 30 Oct 2000 18:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129697AbQJ3X1E>; Mon, 30 Oct 2000 18:27:04 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:1285 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S129830AbQJ3X0u>; Mon, 30 Oct 2000 18:26:50 -0500
Date: Mon, 30 Oct 2000 23:26:17 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
cc: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <Pine.LNX.4.21.0010300934200.872-100000@elte.hu>
Message-ID: <Pine.LNX.4.21.0010302325240.16101-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2000, Ingo Molnar wrote:

> On Mon, 30 Oct 2000, Jeff V. Merkey wrote:
> 
> > Is there an option to map Linux into a flat address space [...]
> 
> nope, Linux is fundamentally multitasked.

uClinux may be able to do this, at the cost of a dramatically reduced
userspace functionality.

-- 
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
