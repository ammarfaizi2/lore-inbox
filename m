Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131933AbQKSLBu>; Sun, 19 Nov 2000 06:01:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131934AbQKSLBk>; Sun, 19 Nov 2000 06:01:40 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:41739 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S131933AbQKSLBh>;
	Sun, 19 Nov 2000 06:01:37 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200011191031.eAJAVZv15167@saturn.cs.uml.edu>
Subject: Re: Error in x86 CPU capabilities starting with test5/6
To: andrea@suse.de (Andrea Arcangeli)
Date: Sun, 19 Nov 2000 05:31:35 -0500 (EST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20001117192834.A30047@athlon.random> from "Andrea Arcangeli" at Nov 17, 2000 07:28:34 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As about the broken calling conventions of the IA32 ABI, I think it
> doesn't worth to break the binary compatibility at this late stage.

We are not at any late stage. The new 64-bit PC processors might
be accepted about as well as Microchannel and EISA were accepted.
Crummy old 32-bit processors will be around much longer than we'd
like them to be.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
