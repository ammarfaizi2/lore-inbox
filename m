Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130834AbRC3GhH>; Fri, 30 Mar 2001 01:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130831AbRC3Gg5>; Fri, 30 Mar 2001 01:36:57 -0500
Received: from mail-klh.telecentrum.de ([213.69.31.130]:52236 "EHLO
	mail-klh.telecentrum.de") by vger.kernel.org with ESMTP
	id <S130824AbRC3Ggo>; Fri, 30 Mar 2001 01:36:44 -0500
Message-ID: <3AC424A2.DF6485DF@topit.de>
Date: Fri, 30 Mar 2001 08:16:02 +0200
From: Ronald Jeninga <rj@topit.de>
Reply-To: rj@topit.de
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: hugang <linuxhappy@etang.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [ISDN-ERR]
In-Reply-To: <20010330100323.791a25c8.linuxhappy@etang.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

man isdn_cause 
says
E  = EDSS1
00 = User Message
1B = Destination out of order

The other end seems to have a problem
Doesn't seem to be a kernel issue though

Ronald Jeninga

hugang wrote:
> 
> Hello all:
> 
> ---------------------------------------
> OPEN: 10.0.0.2 -> 202.99.16.1 UDP, port: 1024 -> 53
> ippp0: dialing 1 86310163...
> isdn: HiSax,ch0 cause: E001B                    <--- error !!
> isdn_net: local hangup ippp0
> ippp0: Chargesum is 0
> ---------------------------------------
>         Can someone tell me ,howto fix it ??
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
