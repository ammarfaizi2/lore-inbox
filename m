Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266120AbSLPSE0>; Mon, 16 Dec 2002 13:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266986AbSLPSE0>; Mon, 16 Dec 2002 13:04:26 -0500
Received: from colina.demon.co.uk ([158.152.133.150]:56194 "EHLO
	colina.demon.co.uk") by vger.kernel.org with ESMTP
	id <S266120AbSLPSEZ>; Mon, 16 Dec 2002 13:04:25 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Alcatel speedtouch USB driver and SMP.
References: <m3n0n7hi52.fsf@colina.demon.co.uk>
	<20021215075913.GB2180@kroah.com> <m3hedfhd5l.fsf@colina.demon.co.uk>
	<20021216051300.GB12884@kroah.com>
From: Colin Paul Adams <colin@colina.demon.co.uk>
Date: 16 Dec 2002 09:02:35 +0000
In-Reply-To: <20021216051300.GB12884@kroah.com>
Message-ID: <m3adj6gwus.fsf@colina.demon.co.uk>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Greg" == Greg KH <greg@kroah.com> writes:
    >>  drivers/usb/misc/speedtouch.c

    Greg> Ah good, you're using one that the source is available for
    Greg> :) I think the developer has said it will work on SMP
    Greg> machines, but what problems are you having, and have you
    Greg> asked the author of the code?

I haven't any problems yet, as I haven't bought the modem yet. I don't
want to if it is going to give me problems.

The 1.4 version of the driver (before integration into 2.5 series
kernel), is supposed to not work with SMP kernels (that's why I asked
in the first place). So I contacted the author (Johan Verrept) to ask on the status,
and he said he thought it was probably OK now, as it was in the 2.5
kernel.

So I grabbed the 2.5.51 sources and looked at the see, and could see
no mention of a change to fix SMP. So I then contacted Richard Purdie,
who was the last person to make a change to the source. He said he
didn't know.

So, is anyone using it on SMP?
-- 
Colin Paul Adams
Preston Lancashire
