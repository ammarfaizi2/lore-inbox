Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130065AbRB1GWW>; Wed, 28 Feb 2001 01:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130071AbRB1GWD>; Wed, 28 Feb 2001 01:22:03 -0500
Received: from web9204.mail.yahoo.com ([216.136.129.27]:19212 "HELO
	web9204.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S130065AbRB1GV5>; Wed, 28 Feb 2001 01:21:57 -0500
Message-ID: <20010228062156.33159.qmail@web9204.mail.yahoo.com>
Date: Tue, 27 Feb 2001 22:21:56 -0800 (PST)
From: bradley mclain <bradley_kernel@yahoo.com>
Subject: -ac6 mis-reports cpu clock
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1535016996-983341316=:33108"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-1535016996-983341316=:33108
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

here is an extract from dmesg from 2.4.2 and -ac6,
showing a disparity in cpu clock speed..

-ac6 has inserted a line claiming my clock is 400Mhz
(it is actually 533 -- and i believe my fsb is 133).

i don't think i compiled these two radically
differently.  what could i have done wrong to cause
this?  or has -ac6 introduced a bug of some sort?

any suggestions for debugging or additional
information?

thanks,
bradley mclain

__________________________________________________
Do You Yahoo!?
Get email at your own domain with Yahoo! Mail. 
http://personal.mail.yahoo.com/
--0-1535016996-983341316=:33108
Content-Type: application/x-unknown; name=compare
Content-Transfer-Encoding: base64
Content-Description: compare
Content-Disposition: attachment; filename=compare

S2VybmVsIGNvbW1hbmQgbGluZTogQk9PVF9JTUFHRT1saW51eC0yLjQuMiBy
byByb290PTM0NgouLi4KQ1BVOiBCZWZvcmUgdmVuZG9yIGluaXQsIGNhcHM6
IDAzODNmYmZmIDAwMDAwMDAwIDAwMDAwMDAwLCB2ZW5kb3IgPSAwCkNQVTog
TDEgSSBjYWNoZTogMTZLLCBMMSBEIGNhY2hlOiAxNksKQ1BVOiBMMiBjYWNo
ZTogMjU2SwpJbnRlbCBtYWNoaW5lIGNoZWNrIGFyY2hpdGVjdHVyZSBzdXBw
b3J0ZWQuCgotLS0tLS0tLS0tLS0KCktlcm5lbCBjb21tYW5kIGxpbmU6IEJP
T1RfSU1BR0U9bGludXgtMjQyYWM2IHJvIHJvb3Q9MzQ2Ci4uLgpDUFU6IEJl
Zm9yZSB2ZW5kb3IgaW5pdCwgY2FwczogMDM4M2ZiZmYgMDAwMDAwMDAgMDAw
MDAwMDAsIHZlbmRvciA9IDAKQ1BVOiBMMSBJIGNhY2hlOiAxNkssIEwxIEQg
Y2FjaGU6IDE2SwpDUFU6IEwyIGNhY2hlOiAyNTZLCkNQVSBzcGVlZCA0MDBN
aHosIEJ1cyBTcGVlZCAxMDBNSHoKSW50ZWwgbWFjaGluZSBjaGVjayBhcmNo
aXRlY3R1cmUgc3VwcG9ydGVkLgpJbnRlbCBtYWNoaW5lIGNoZWNrIHJlcG9y
dGluZyBlbmFibGVkIG9uIENQVSMwLg==

--0-1535016996-983341316=:33108--
