Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129675AbRALEfq>; Thu, 11 Jan 2001 23:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132608AbRALEfg>; Thu, 11 Jan 2001 23:35:36 -0500
Received: from james.kalifornia.com ([208.179.0.2]:39731 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S129675AbRALEf1>; Thu, 11 Jan 2001 23:35:27 -0500
Message-ID: <3A5E8984.E2E4162B@linux.com>
Date: Thu, 11 Jan 2001 20:35:16 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bob_Tracy <rct@gherkin.sa.wlk.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: depmod -a and 2.4.0
In-Reply-To: <m14GvKu-0005keC@gherkin.sa.wlk.com>
Content-Type: multipart/mixed;
 boundary="------------C26B7FEA419A8CDCE3EAA104"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------C26B7FEA419A8CDCE3EAA104
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> pretty darned impressive :-).  Another oddity that someone else
> already reported: the ipv6 module shows a reference count of -1.

a ref count of -1 means the module decides when to unload.

-d


--------------C26B7FEA419A8CDCE3EAA104
Content-Type: text/x-vcard; charset=us-ascii;
 name="david.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for David Ford
Content-Disposition: attachment;
 filename="david.vcf"

begin:vcard 
n:Ford;David
x-mozilla-html:TRUE
url:www.blue-labs.org
adr:;;;;;;
version:2.1
email;internet:david@blue-labs.org
title:Blue Labs Developer
note;quoted-printable:GPG key: http://www.blue-labs.org/david@nifty.key=0D=0A
x-mozilla-cpt:;9952
fn:David Ford
end:vcard

--------------C26B7FEA419A8CDCE3EAA104--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
