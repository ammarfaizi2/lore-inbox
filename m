Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129787AbQK0VZg>; Mon, 27 Nov 2000 16:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129927AbQK0VZ0>; Mon, 27 Nov 2000 16:25:26 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:65034 "EHLO
        neon-gw.transmeta.com") by vger.kernel.org with ESMTP
        id <S129787AbQK0VZM>; Mon, 27 Nov 2000 16:25:12 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: About IP address
Date: 27 Nov 2000 12:55:06 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8vuhna$sb3$1@cesium.transmeta.com>
In-Reply-To: <07bf01c05664$15462210$0a25a8c0@wizardess.wiz> <Pine.LNX.4.30.0011241729270.5879-100000@asdf.capslock.lan> <20001127163217.B20394@alcove.wittsend.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20001127163217.B20394@alcove.wittsend.com>
By author:    "Michael H. Warfield" <mhw@wittsend.com>
In newsgroup: linux.dev.kernel
> 
> 	Glad you can't understand it, because it's incorrect.  They can
> be used but they are both assigned to IANA (Internet Assigned Numbers
> Authority) as reserved address blocks.  You can't use them because IANA
> controls them and dictates how they might be used if they are ever
> used.  Since there may be broken software out there that mishandles
> those addresses, it's entirely possible that IANA will never use them
> for any routable purpose.  Neither currently have reverse name servers
> assigned, so it's presumable that they are simply not in operation
> and IANA is keeping them reserved to keep them out of trouble.
> 

Most likely, they have put them in a bin saying "potentially
troublesome with old software, assign them last."  As long as there
are other addresses available, they won't be used.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
