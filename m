Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135257AbRAHVwC>; Mon, 8 Jan 2001 16:52:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132964AbRAHVvw>; Mon, 8 Jan 2001 16:51:52 -0500
Received: from piglet.twiddle.net ([207.104.6.26]:45841 "EHLO
	piglet.twiddle.net") by vger.kernel.org with ESMTP
	id <S135318AbRAHVvo>; Mon, 8 Jan 2001 16:51:44 -0500
Date: Mon, 8 Jan 2001 13:51:34 -0800
From: Richard Henderson <rth@twiddle.net>
To: Andi Kleen <ak@suse.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: [PATCH,serious] Fix raid5 crashes in 2.4.0
Message-ID: <20010108135134.A28394@twiddle.net>
In-Reply-To: <20010108181625.A11766@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <20010108181625.A11766@gruyere.muc.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2001 at 06:16:25PM +0100, Andi Kleen wrote:
> This patch just makes the SSE2 code conditional on ...

Pedanticly, this is SSE1 code.


r~
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
