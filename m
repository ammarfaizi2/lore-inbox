Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282946AbRLCIvx>; Mon, 3 Dec 2001 03:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282953AbRLCIs6>; Mon, 3 Dec 2001 03:48:58 -0500
Received: from mpdr0.chicago.il.ameritech.net ([206.141.239.142]:43742 "EHLO
	mailhost.chi.ameritech.net") by vger.kernel.org with ESMTP
	id <S284759AbRLCEvO>; Sun, 2 Dec 2001 23:51:14 -0500
Message-ID: <3C0B0514.A26AA021@ameritech.net>
Date: Sun, 02 Dec 2001 22:52:36 -0600
From: watermodem <aquamodem@ameritech.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jessica@twu.net
CC: linux-kernel@vger.kernel.org
Subject: Re: Slow start -- Linux vs. NT -- it's time to acknowledge theproblem!
In-Reply-To: <Pine.LNX.4.40.0111300834270.3351-100000@twu.net> <20011130.142843.31639840.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
>    From: Jessica Blank <jessica@twu.net>
>    Date: Fri, 30 Nov 2001 08:35:35 -0600 (CST)
> 
>         It is high time this problem is acknowledged and FIXED. I am
>    forced to share a network with a bunch of NT servers, some of which get
>    plenty of traffic-- enough so that they manage to crowd out my machine to
>    the tune of 600ish ms ping times to the Linux box versus only **70**
>    (!!!!!!) to the Windows box.
 
600ms looks like 10base T (no duplex).
  Not full duplex or 100base T.
Check you cable!

> 
> Changes to TCP and therefore anything having to do with
> slow-start is not going to have any effect on ping times.
> 
> To me this sounds like a problem somewhere else, perhaps a driver
> issue.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
