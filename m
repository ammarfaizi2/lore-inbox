Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281015AbRKTKcv>; Tue, 20 Nov 2001 05:32:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281016AbRKTKcc>; Tue, 20 Nov 2001 05:32:32 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:56333 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S281015AbRKTKc0>; Tue, 20 Nov 2001 05:32:26 -0500
Date: Tue, 20 Nov 2001 13:31:50 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Richard Henderson <rth@redhat.com>
Cc: Jay.Estabrook@compaq.com, linux-kernel@vger.kernel.org
Subject: Re: [alpha] cleanup opDEC workaround
Message-ID: <20011120133150.A9033@jurassic.park.msu.ru>
In-Reply-To: <20011119232355.C16091@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011119232355.C16091@redhat.com>; from rth@redhat.com on Mon, Nov 19, 2001 at 11:23:55PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2001 at 11:23:55PM -0800, Richard Henderson wrote:
> --- 2.4.15-7/arch/alpha/kernel/traps.c.~2~	Mon Nov 19 23:05:50 2001
> +++ 2.4.15-7/arch/alpha/kernel/traps.c	Mon Nov 19 23:07:32 2001

It seems to be the wrong diff:

patching file arch/alpha/kernel/traps.c
Hunk #1 succeeded at 23 (offset -1 lines).
Hunk #3 succeeded at 283 (offset -1 lines).
Hunk #4 FAILED at 299.
Hunk #5 FAILED at 313.
Hunk #6 succeeded at 988 (offset -14 lines).
2 out of 6 hunks FAILED -- saving rejects to file arch/alpha/kernel/traps.c.rej

Ivan.
