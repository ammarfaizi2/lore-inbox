Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273349AbRJIHWo>; Tue, 9 Oct 2001 03:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273515AbRJIHWY>; Tue, 9 Oct 2001 03:22:24 -0400
Received: from mailserv.intranet.GR ([146.124.14.106]:44453 "EHLO
	mailserv.intranet.gr") by vger.kernel.org with ESMTP
	id <S273349AbRJIHWN>; Tue, 9 Oct 2001 03:22:13 -0400
Message-ID: <3BC2A65F.67B7D415@intracom.gr>
Date: Tue, 09 Oct 2001 10:25:19 +0300
From: Pantelis Antoniou <panto@intracom.gr>
Organization: INTRACOM S.A.
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.2.18pre21 ppc)
X-Accept-Language: el, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Standard way of generating assembler offsets
In-Reply-To: <28136.1002196028@ocs3.intra.ocs.com.au>
		<3BC1735F.41CBF5C1@intracom.gr> <20011008.024946.74749362.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
>    From: Pantelis Antoniou <panto@intracom.gr>
>    Date: Mon, 08 Oct 2001 12:35:27 +0300
> 
>    If anyone is interested I have already made a perl
>    script that produces assembler offsets from structure
>    members.
> 
>    It doesn't need to run native since it reads the
>    header files, extract the structures and by using
>    objdump calculates the offsets automatically.
> 
> BTW, I assume you have already taken a look at how we
> do this on Sparc64.  See arch/sparc64/kernel/check_asm.sh
> and the "check_asm" target in arch/sparc64/kernel/Makefile
> 
> It also works in all cross-compilation etc. environments.
> And I bet it would work on every platform with very minimal
> changes, if any.
> 
> Franks a lot,
> David S. Miller
> davem@redhat.com

I've look at your script and it kinda flew over my head.

Would you mind explain this a bit?

Thanks
