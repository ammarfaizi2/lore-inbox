Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129991AbQKRR7P>; Sat, 18 Nov 2000 12:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129955AbQKRR6z>; Sat, 18 Nov 2000 12:58:55 -0500
Received: from inet-smtp4.oracle.com ([209.246.15.58]:52718 "EHLO
	inet-smtp4.us.oracle.com") by vger.kernel.org with ESMTP
	id <S129911AbQKRR6q>; Sat, 18 Nov 2000 12:58:46 -0500
Message-ID: <3A16BC4B.8914A1FA@oracle.com>
Date: Sat, 18 Nov 2000 09:28:44 -0800
From: Josue Emmanuel Amaro <Josue.Amaro@oracle.com>
Organization: Linux Strategic Business Unit, Oracle Corporation
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Frank van Maarseveen <F.vanMaarseveen@inter.NL.net>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, dalecki@evision-ventures.com,
        linux-kernel@vger.kernel.org
Subject: Re: ORACLE and 2.4-test10
In-Reply-To: <3A157E06.37255710@evision-ventures.com> <E13wq1g-0000zo-00@the-village.bc.nu> <20001118120715.A6449@iapetus.localdomain>
Content-Type: multipart/mixed;
 boundary="------------FDE447559AB4D0DEE763D3DB"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------FDE447559AB4D0DEE763D3DB
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Frank,

You must be looking at Oracle 8.0 docs. If you are looking to update a production
system we only support stable kernels.  Pre kernels  are not yet really stable and
therefore not supported.  (We had to draw the line somewhere.)

That said, we will look into O_DIRECT and kiovects.  We may be able to do some
performance testing on that.

Regards,

Frank van Maarseveen wrote:

> On Fri, Nov 17, 2000 at 06:14:14PM +0000, Alan Cox wrote:
> > SHM is resolved but O_SYNC is not yet fixed. You could therefore easily lose
> > your entire database
>
> I assume 2.2.18-pre-latest is ok?
> Some oracle doc still refers to 2.0.34
>
> --
> Frank
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

--
=======================================================================
  Josue Emmanuel Amaro                         Josue.Amaro@oracle.com
  Linux Products Manager                       Phone:   650.506.1239
  Intel and Linux Technologies Group           Fax:     650.413.0167
=======================================================================


--------------FDE447559AB4D0DEE763D3DB
Content-Type: text/x-vcard; charset=us-ascii;
 name="Josue.Amaro.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Josue Emmanuel Amaro
Content-Disposition: attachment;
 filename="Josue.Amaro.vcf"

begin:vcard 
n:Amaro;Josue Emmanuel
tel;cell:650-245-5131
tel;fax:650-413-0167
tel;work:650-506-1239
x-mozilla-html:FALSE
url:http://www.oracle.com
org:Intel and Linux Technologies
version:2.1
email;internet:Josue.Amaro@oracle.com
title:Sr.Product Manager - Linux
adr;quoted-printable:;;500 Oracle Parkway=0D=0AMS1ip4;Redwood Shores;CA;94065;United States
fn:Josue Emmanuel Amaro
end:vcard

--------------FDE447559AB4D0DEE763D3DB--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
