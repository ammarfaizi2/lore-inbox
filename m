Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130089AbQKCWgs>; Fri, 3 Nov 2000 17:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131099AbQKCWgi>; Fri, 3 Nov 2000 17:36:38 -0500
Received: from inet-smtp3.oracle.com ([205.227.43.23]:22769 "EHLO
	inet-smtp3.oracle.com") by vger.kernel.org with ESMTP
	id <S130089AbQKCWgZ>; Fri, 3 Nov 2000 17:36:25 -0500
Message-ID: <3A033DE6.F4CD60C1@oracle.com>
Date: Fri, 03 Nov 2000 14:36:22 -0800
From: Josue Emmanuel Amaro <Josue.Amaro@oracle.com>
Organization: Linux Strategic Business Unit, Oracle Corporation
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Value of TASK_UNMAPPED_SIZE on 2.4
In-Reply-To: <fa.d4dt9vv.1gm6abv@ifi.uio.no> <fa.ebii26v.1mgevrq@ifi.uio.no> <80snp8reck.fsf@orthanc.exbit-technology.com> <20001103214613.C17349@athlon.random>
Content-Type: multipart/mixed;
 boundary="------------26C1F364FA1E656AEB3027F1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------26C1F364FA1E656AEB3027F1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Andrea,

We will give it a try.

How difficult would it be to move that patch to 2.4?

It would be great if it could be a kernel configuration time option.

Regards,

Andrea Arcangeli wrote:

> On Fri, Nov 03, 2000 at 09:27:07PM +0100, Kai Harrekilde-Petersen wrote:
> > Is this available as a patch, or preferably as a compilation option to
>
> They're available here:
>
>         ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.2/2.2.14/bigmem-large-mapping-1.bz2
>         ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.2/2.2.14/bigmem-large-task-1.bz2
>
> But they're against 2.2.x + bigmem. The first one is still valid (and it's
> similar to the one discussed here). The second one doesn't apply to 2.4.x
> and both vmlinux.lds and PAGE_OFFSET should be changed that way to
> make it to work there.
>
> Andrea
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


--------------26C1F364FA1E656AEB3027F1
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

--------------26C1F364FA1E656AEB3027F1--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
