Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129145AbQKIW1Z>; Thu, 9 Nov 2000 17:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129248AbQKIW1Q>; Thu, 9 Nov 2000 17:27:16 -0500
Received: from [62.172.234.2] ([62.172.234.2]:23173 "EHLO saturn.homenet")
	by vger.kernel.org with ESMTP id <S129145AbQKIW1E>;
	Thu, 9 Nov 2000 17:27:04 -0500
Date: Thu, 9 Nov 2000 22:28:03 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch-2.4.0-test11-pre1] broken comment around paging_init()
In-Reply-To: <Pine.LNX.4.21.0011092219450.827-100000@saturn.homenet>
Message-ID: <Pine.LNX.4.21.0011092226200.827-100000@saturn.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Nov 2000, Tigran Aivazian wrote:
> The comment above arch/i386/mm/init.c:paging_init() lies shamelessly -- we
                                                      ~~~~~~~~~~~~~~~~
correction -- it doesn't lie since [0,4M] \subset [0,8M] -- it just
doesn't tell the human everything he may want to see :)

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
