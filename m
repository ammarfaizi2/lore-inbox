Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130151AbRAKFff>; Thu, 11 Jan 2001 00:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130164AbRAKFfP>; Thu, 11 Jan 2001 00:35:15 -0500
Received: from james.kalifornia.com ([208.179.0.2]:43612 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S130151AbRAKFfI>; Thu, 11 Jan 2001 00:35:08 -0500
Message-ID: <3A5D4606.B039E96@linux.com>
Date: Wed, 10 Jan 2001 21:35:02 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>, nils@kernelconcepts.de,
        twoller@crystal.cirrus.com
Subject: cs46xx only works as a module still (post 2.4.0)
Content-Type: multipart/mixed;
 boundary="------------24C0F4A10225AA47D834D823"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------24C0F4A10225AA47D834D823
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Just a friendly reminder, the cs46xx driver only works if it's compiled
as a module.  If it's static, it never gets activated on boot.

-d


--------------24C0F4A10225AA47D834D823
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

--------------24C0F4A10225AA47D834D823--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
