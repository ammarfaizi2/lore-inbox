Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130766AbRA0HWh>; Sat, 27 Jan 2001 02:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131665AbRA0HW2>; Sat, 27 Jan 2001 02:22:28 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:40716 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S130766AbRA0HWY>;
	Sat, 27 Jan 2001 02:22:24 -0500
Message-ID: <3A727724.F4E8161C@mandrakesoft.com>
Date: Sat, 27 Jan 2001 02:22:12 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Aaron Tiensivu <mojomofo@mojomofo.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.0ac12 (ppp-generic)
In-Reply-To: <E14MIgn-0003G5-00@the-village.bc.nu> <027701c087fb$17d83400$0300a8c0@methusela>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aaron Tiensivu wrote:
> 
> | o Set last_rx on ppp_generic (Jeff Garzik)
> 
> Is this related to my MPPP crashes or is this an unrelated fix?

I don't know how MPPP works, so I can't say for sure, but it is most
likely an unrelated fix.

	Jeff


-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
