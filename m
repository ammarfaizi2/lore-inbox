Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129599AbQKMW0z>; Mon, 13 Nov 2000 17:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129604AbQKMW0p>; Mon, 13 Nov 2000 17:26:45 -0500
Received: from inet-smtp3.oracle.com ([205.227.43.23]:37068 "EHLO
	inet-smtp3.oracle.com") by vger.kernel.org with ESMTP
	id <S129599AbQKMW0d>; Mon, 13 Nov 2000 17:26:33 -0500
Message-ID: <3A106380.CE41BBAE@oracle.com>
Date: Mon, 13 Nov 2000 13:56:16 -0800
From: Josue Emmanuel Amaro <Josue.Amaro@oracle.com>
Organization: Linux Strategic Business Unit, Oracle Corporation
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Advanced Linux Kernel/Enterprise Linux Kernel
In-Reply-To: <80256991.007632DE.00@d06mta06.portsmouth.uk.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------996C7B2ED4685298B8C3F5CE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------996C7B2ED4685298B8C3F5CE
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

This subject came up in the Generalized Kernel Hooks Interface thread, since it
is an area of interest to me I wanted to continue that conversation.

While I do not think it would be productive to enter a discussion whether there
is a need to fork the kernel to add features that would be beneficial to
mission/business critical applications, I am curious as to what are the features
that people consider important to have.  By mission critical I mean systems that
if not functional bring a business to a halt, while by business critical I mean
systems that affect a division of a business.

Another problem is how people define Enterprise Systems.  Many base it on the
definitions that go back to S390 systems, others in the context of the 24/7
nature of the internet.  That would also be a healthy discussion to have.

At Oracle we are primarily interested on I/O subsystem features and memory
management.  (For anyone that knows anything about Oracle this should not come
as a surprise, although I am pretty sure that any database vendor/developer
would be interested on those features as well.)

Regards,

--
=======================================================================
  Josue Emmanuel Amaro                         Josue.Amaro@oracle.com
  Linux Products Manager
  Intel and Linux Technologies Group
=======================================================================


--------------996C7B2ED4685298B8C3F5CE
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

--------------996C7B2ED4685298B8C3F5CE--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
