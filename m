Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154837AbPIAWDS>; Wed, 1 Sep 1999 18:03:18 -0400
Received: by vger.rutgers.edu id <S154744AbPIAWC4>; Wed, 1 Sep 1999 18:02:56 -0400
Received: from int2.nea-fast.com ([208.241.120.39]:61624 "EHLO int2.nea-fast.com") by vger.rutgers.edu with ESMTP id <S154850AbPIAVuT>; Wed, 1 Sep 1999 17:50:19 -0400
Message-ID: <37CD9F8F.F3881475@pobox.com>
Date: Wed, 01 Sep 1999 17:50:07 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
X-Mailer: Mozilla 4.6 [en] (X11; I; Linux 2.3.16 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.rutgers.edu
Subject: Re: Universal Driver Interface spec available
References: <E11MI2e-0003fR-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

Alan Cox wrote:
> Not sure why anyone thinks this is Linux relevant 8) - other than it will help
> to make our drivers even faster than the competition if they adopt it.
> Have a read, but keep a bucket handy

In response to you and David:  I agree :)  But if vendors take this
seriously, I have a feeling a UDI interface will eventually appear. 
Lack of UDI support may be an encouragement or a discouragement,
depending on the complexity of the device driver.

On a related subject, I think Linux could use a much more coherent --
and documented -- device driver interface.  Writing portable Linux
device drivers requires very in-depth knowledge of the Linux 'arch'
code; I find myself checking the Alpha or Sparc arch code a lot to make
sure that the I/O routines and such that I call work as expected.

Regards,

	Jeff




-- 
Americans' greatest fear is that America will turn out to have been a
phenomenon, not a civilization.
                -- Shirley Hazzard, "Transit of Venus"

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
