Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbRAYVxn>; Thu, 25 Jan 2001 16:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129867AbRAYVxd>; Thu, 25 Jan 2001 16:53:33 -0500
Received: from [64.64.109.142] ([64.64.109.142]:14355 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S129406AbRAYVx3>; Thu, 25 Jan 2001 16:53:29 -0500
Message-ID: <3A709FF9.86F8268C@didntduck.org>
Date: Thu, 25 Jan 2001 16:51:53 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.73 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: "David L. Nicol" <david@kasey.umkc.edu>
CC: linux-kernel@vger.kernel.org, chris.ricker@genetics.utah.edu
Subject: Re: "no such 386 instruction" with gcc 2.95.2
In-Reply-To: <3A709EC8.72C3F911@kasey.umkc.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David L. Nicol" wrote:
> 
> I think I must need to upgrade my assembler, but:
> 2.4.0/Documentation/Changes does not list an assembler version.

The gas assembler is part of binutils.

--

				Brian Gerst
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
