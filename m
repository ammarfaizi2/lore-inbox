Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130282AbRALKEZ>; Fri, 12 Jan 2001 05:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130376AbRALKEP>; Fri, 12 Jan 2001 05:04:15 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:35589 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130282AbRALKEE>; Fri, 12 Jan 2001 05:04:04 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: khttpd beaten by boa
Date: 12 Jan 2001 02:03:32 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <93mkpk$98k$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.21.0101071655090.1110-100000@home.lameter.com> <Pine.LNX.4.21.0101112214040.22231-100000@home.lameter.com> <20010112084259.B441@marowsky-bree.de> <14942.48157.259491.78067@pizda.ninka.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <14942.48157.259491.78067@pizda.ninka.net>
By author:    "David S. Miller" <davem@redhat.com>
In newsgroup: linux.dev.kernel
> 
> Lars Marowsky-Bree writes:
>  > This just goes on to show that khttpd is unnecessary kernel bloat
>  > and can be "just as well" handled by a userspace application, minus
>  > some rather very special cases which do not justify its inclusion
>  > into the main kernel.
> 
> My take on this is that khttpd is unmaintained garbage.
> 
> TUX is evidence that khttpd can be done properly and
> beat the pants off of anything done in userspace.
> 

Then why don't we unload khttpd and put in Tux?

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
