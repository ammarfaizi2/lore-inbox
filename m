Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132163AbQLHOET>; Fri, 8 Dec 2000 09:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132253AbQLHOEJ>; Fri, 8 Dec 2000 09:04:09 -0500
Received: from host55.osagesoftware.com ([209.142.225.55]:29966 "EHLO
	netmax.osagesoftware.com") by vger.kernel.org with ESMTP
	id <S132234AbQLHODv>; Fri, 8 Dec 2000 09:03:51 -0500
Message-Id: <4.3.2.7.2.20001208081657.00b15220@mail.osagesoftware.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Fri, 08 Dec 2000 08:19:46 -0500
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
From: David Relson <relson@osagesoftware.com>
Subject: Re: [Fwd: NTFS repair tools]
Cc: "Michael H. Warfield" <mhw@wittsend.com>,
        Peter Samuelson <peter@cadcamlab.org>, linux-kernel@vger.kernel.org
In-Reply-To: <3A306994.63DB8208@timpanogas.org>
In-Reply-To: <3A30552D.A6BE248C@timpanogas.org>
 <20001207221347.R6567@cadcamlab.org>
 <3A3066EC.3B657570@timpanogas.org>
 <20001208005337.A26577@alcove.wittsend.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:54 PM 12/7/00, Jeff V. Merkey wrote:


>Linux today monitors this list.  Some public education may be the best
>route.  How do we post a security advisory warning people that will get
>posted?  I'm sure folks see the DANGEROUS comments, but they don't seem
>to stick in their heads.  Then they get themselves into trouble, and
>fortunately for them, I'm around.  I am just concerned about the scope
>of the black eye that will just keep getting bigger and bigger for Linux
>NTFS.


FWIW, Mandrake Linux includes a tool MandrakeUpdate which allows 
downloading of "Normal Updates" or "Development Updates".  If you chose 
Devel Upd, you get the following warning:

         Caution !  These packages are NOT well tested.
         You really can screw up your system
         by installing them.

Perhaps the configure tools could recognize a DANGEROUS status (or keyword 
or ???) and would display such a message ...

David

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
