Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131000AbQLJUkh>; Sun, 10 Dec 2000 15:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131036AbQLJUk2>; Sun, 10 Dec 2000 15:40:28 -0500
Received: from james.kalifornia.com ([208.179.0.2]:45400 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S131000AbQLJUkS>; Sun, 10 Dec 2000 15:40:18 -0500
Message-ID: <3A33E30C.618F665B@linux.com>
Date: Sun, 10 Dec 2000 12:09:49 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: test12-pre8 tq_struct compile failures
Content-Type: multipart/mixed;
 boundary="------------F03BA40A97F98D9F4227D741"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------F03BA40A97F98D9F4227D741
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

There seem to be quite a lot of compile failures wrt tq_struct.

Does anyone have a template patch to use to start fixing these?

-d


--------------F03BA40A97F98D9F4227D741
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

--------------F03BA40A97F98D9F4227D741--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
