Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129728AbQJ1Edt>; Sat, 28 Oct 2000 00:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129915AbQJ1Edk>; Sat, 28 Oct 2000 00:33:40 -0400
Received: from vpop1-135.pacificnet.net ([209.204.32.135]:2820 "EHLO
	cx518206-b.irvn1.occa.home.com") by vger.kernel.org with ESMTP
	id <S129728AbQJ1Ed1>; Sat, 28 Oct 2000 00:33:27 -0400
From: "Barry K. Nathan" <barryn@cx518206-b.irvn1.occa.home.com>
Message-Id: <200010280432.VAA01337@cx518206-b.irvn1.occa.home.com>
Subject: IA-32 (was Re: [PATCH] cpu detection fixes for test10-pre4)
To: hpa@transmeta.com (H. Peter Anvin)
Date: Fri, 27 Oct 2000 21:32:48 -0700 (PDT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        vonbrand@inf.utfsm.cl (Horst von Brand), linux-kernel@vger.kernel.org
Reply-To: barryn@pobox.com
In-Reply-To: <39F9F01B.518C5EC1@transmeta.com> from "H. Peter Anvin" at Oct 27, 2000 02:14:03 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:

> Alan Cox wrote:

[snip]

> > ia32 is an intel trademark. Using it for non intel products is probably an
> > actionable matter ..
> > 
> 
> Yet another reason to ignore it.

Speaking of using it for non-Intel products, this is a line from
Documentation/Changes in Linux 2.4.0-test10-pre6:

Linux on IA-32 has recently switched from using as86 to using gas for

Should we change that to x86 or something?

-Barry K. Nathan <barryn@pobox.com>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
