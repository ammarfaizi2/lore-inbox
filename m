Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129348AbRADHKR>; Thu, 4 Jan 2001 02:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130110AbRADHKH>; Thu, 4 Jan 2001 02:10:07 -0500
Received: from webmail.metabyte.com ([216.218.208.53]:4196 "EHLO
	webmail.metabyte.com") by vger.kernel.org with ESMTP
	id <S129348AbRADHJy>; Thu, 4 Jan 2001 02:09:54 -0500
Message-ID: <3A542148.AAE1D8E9@metabyte.com>
Date: Wed, 03 Jan 2001 23:07:52 -0800
From: Pete Zaitcev <zaitcev@metabyte.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: So, what about kwhich on RH6.2?
In-Reply-To: <3A541361.65942CB3@metabyte.com> <200101040611.WAA01811@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Jan 2001 07:09:52.0891 (UTC) FILETIME=[559DD4B0:01C0761D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    Date:        Wed, 03 Jan 2001 22:08:33 -0800
>    From: Pete Zaitcev <zaitcev@metabyte.com>
> 
>    Are we going to use Miquel's patch? I cannot build fresh 2.2.x on
>    plain RH6.2 without it. The 2.2.19-pre6 comes out without it.  Or
>    is "install new bash" the official answer? Alan?
> 
> I do not understand, I just got a working 2.2.19-pre6 build on one of
> my 6.2 Sparc64 systems, what kind of failure do you see?

Oops. I cannot reproduce it anymore. Since I am quite sure
in my recollection of this problem, I conclude that there
was a kernel (perhaps 2.2.19-pre3), that called kwhich with
several arguments. No problem now on the pre6.

-- Pete
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
