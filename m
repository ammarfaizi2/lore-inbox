Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132091AbRAPWyU>; Tue, 16 Jan 2001 17:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132645AbRAPWyK>; Tue, 16 Jan 2001 17:54:10 -0500
Received: from cx518206-a.irvn1.occa.home.com ([24.21.107.122]:34798 "EHLO
	pobox.com") by vger.kernel.org with ESMTP id <S132091AbRAPWyC>;
	Tue, 16 Jan 2001 17:54:02 -0500
From: "Barry K. Nathan" <barryn@pobox.com>
Message-Id: <200101162253.f0GMrvU01248@pobox.com>
Subject: Re: lance.c @ 100Mbit
To: eli.carter@inet.com (Eli Carter)
Date: Tue, 16 Jan 2001 14:53:57 -0800 (PST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A64CADF.17C9B9A3@inet.com> from "Eli Carter" at Jan 16, 2001 04:27:43 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Quick question:  has anyone used the lance.c driver for a 100BaseT
> network PCI device?  If so, what successes/failures did you run into?

Never used lance.c for 100BaseT (can it do that?). I've used the pcnet32.c
driver, however.

> (I'm working with an Am79C973 chip.)

In my case, Am79C971. Works great for me, under both 2.2 and 2.4. (I don't
have any SMP systems, FWIW.)

-Barry K. Nathan <barryn@pobox.com>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
