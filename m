Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129166AbQKJKGs>; Fri, 10 Nov 2000 05:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129210AbQKJKGi>; Fri, 10 Nov 2000 05:06:38 -0500
Received: from pop08-1-ras1-p27.barak.net.il ([212.150.109.27]:9476 "EHLO
	champ.linuxnet.org.il") by vger.kernel.org with ESMTP
	id <S129166AbQKJKGW>; Fri, 10 Nov 2000 05:06:22 -0500
Message-ID: <3A0BC699.791064BE@xpert.com>
Date: Fri, 10 Nov 2000 11:57:45 +0200
From: Constantine Gavrilov <const-g@xpert.com>
Reply-To: Constantine Gavrilov <const-g@xpert.com>
Organization: Xpert
X-Mailer: Mozilla 4.7 [en] (X11; U; Linux 2.2.16pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matti Aarnio <matti.aarnio@zmailer.org>
CC: willy tarreau <wtarreau@yahoo.fr>, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.18pre21
In-Reply-To: <20001110092846.29847.qmail@web1102.mail.yahoo.com> <20001110114425.E13151@mea-ext.zmailer.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matti Aarnio wrote:
> 
> On Fri, Nov 10, 2000 at 10:28:46AM +0100, willy tarreau wrote:
> 
>   From the patch source:
> 
> +CONFIG_BONDING
> +  Say 'Y' or 'M' if you wish to be able to 'bond' multiple Ethernet
> +  Channels together. This is called 'Etherchannel' by Cisco,
> +  'Trunking' by Sun, and 'Bonding' in Linux.
> 
>         I think "bonding" is term used in one particular type
>         of ISDN multilink calls.
> 
>         Cisco Trademark is  EtherChannel -- there the capitalization
>         is important.  We could call it ETHERNETCHANNEL (and even
>         "Etherchannel" or "ETHERCHANNEL") get away with it clean.
> 
> ...
> > Regards,
> > Willy
> 
> /Matti Aarnio

ISDN uses "channel bonding", not bonding. As for "Etherchannel", let us change
it to "EtherChannel" is this is how it is called.

-- 
----------------------------------------
Constantine Gavrilov
Unix System Administrator and Programmer
Xpert Integrated Systems
1 Shenkar St, Herzliya 46725, Israel
Phone: (972-8)-952-2361
Fax:   (972-9)-952-2366
----------------------------------------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
