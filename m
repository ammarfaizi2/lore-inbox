Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317022AbSFFRIu>; Thu, 6 Jun 2002 13:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317023AbSFFRIt>; Thu, 6 Jun 2002 13:08:49 -0400
Received: from mailf.telia.com ([194.22.194.25]:9446 "EHLO mailf.telia.com")
	by vger.kernel.org with ESMTP id <S317022AbSFFRIs>;
	Thu, 6 Jun 2002 13:08:48 -0400
To: Alessandro Suardi <alessandro.suardi@oracle.com>
Cc: linux-kernel@vger.kernel.org, Peter Osterlund <petero2@telia.com>,
        mochel <mochel@osdl.org>
Subject: Re: 2.5.20 - Xircom PCI Cardbus doesn't work
In-Reply-To: <3CFB4DDC.30704@oracle.com>
From: Peter Osterlund <petero2@telia.com>
Date: 06 Jun 2002 19:08:40 +0200
Message-ID: <m2bsaomj1j.fsf@ppro.localdomain>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alessandro Suardi <alessandro.suardi@oracle.com> writes:

> In 2.5.19 I got an oops on boot (kindly fixed by Peter's patch),
>   in 2.5.20 no oopsen but eth0 isn't seen anymore by the kernel:

Same problem here. My network card isn't seen either by the kernel in
2.5.20. If it's still broken in 2.5.21, maybe I'll try to fix it.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
