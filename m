Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276836AbRJHJcn>; Mon, 8 Oct 2001 05:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276841AbRJHJce>; Mon, 8 Oct 2001 05:32:34 -0400
Received: from mailserv.intranet.GR ([146.124.14.106]:39653 "EHLO
	mailserv.intranet.gr") by vger.kernel.org with ESMTP
	id <S276839AbRJHJcZ>; Mon, 8 Oct 2001 05:32:25 -0400
Message-ID: <3BC1735F.41CBF5C1@intracom.gr>
Date: Mon, 08 Oct 2001 12:35:27 +0300
From: Pantelis Antoniou <panto@intracom.gr>
Organization: INTRACOM S.A.
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.2.18pre21 ppc)
X-Accept-Language: el, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Standard way of generating assembler offsets
In-Reply-To: <28136.1002196028@ocs3.intra.ocs.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there.

If anyone is interested I have already made a perl
script that produces assembler offsets from structure
members.

It doesn't need to run native since it reads the
header files, extract the structures and by using
objdump calculates the offsets automatically.

Maybe it needs some more work for what you describe, 
but it's exactly what you describe.

If you're interested please email me directly for
more information.

Regards
