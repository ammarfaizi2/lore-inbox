Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131056AbQKNT1K>; Tue, 14 Nov 2000 14:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131320AbQKNT0r>; Tue, 14 Nov 2000 14:26:47 -0500
Received: from piglet.twiddle.net ([207.104.6.26]:49680 "EHLO
	piglet.twiddle.net") by vger.kernel.org with ESMTP
	id <S130361AbQKNT0o>; Tue, 14 Nov 2000 14:26:44 -0500
Date: Tue, 14 Nov 2000 10:56:28 -0800
From: Richard Henderson <rth@twiddle.net>
To: Michal Jaegermann <michal@harddata.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __builtin_expect in 2.4.0-test11pre4
Message-ID: <20001114105628.C2704@twiddle.net>
In-Reply-To: <20001114095800.A2526@mail.harddata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <20001114095800.A2526@mail.harddata.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2000 at 09:58:00AM -0700, Michal Jaegermann wrote:
> +#include <asm/compiler.h>

Ug.  Of course, this is what I intended after having added
the define to compiler.h.


r~
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
