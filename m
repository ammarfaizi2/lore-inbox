Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRAESQz>; Fri, 5 Jan 2001 13:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129387AbRAESQg>; Fri, 5 Jan 2001 13:16:36 -0500
Received: from nat5.tuxia.com ([213.209.134.199]:18436 "EHLO pluto.agb.tuxia")
	by vger.kernel.org with ESMTP id <S129183AbRAESQc>;
	Fri, 5 Jan 2001 13:16:32 -0500
From: Juergen Schneider <juergen.schneider@tuxia.com>
Organization: TUXIA Deutschland GmbH
To: Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] changes to buffer.c (was Test12 ll_rw_block error)
Date: Fri, 5 Jan 2001 19:09:21 +0100
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <662960000.978710044@tiny>
In-Reply-To: <662960000.978710044@tiny>
MIME-Version: 1.0
Message-Id: <01010519155400.00612@pluto>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

I don't know if this is already known,
but this patch seems to solve the loop block device problem too.
I've tested it several times and did not get any kernel lockups after
applying the patch.
Until now this was a showstopper for me but you gave the solution.
Thank you very much.

Juergen Schneider
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
