Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289581AbSBGPlw>; Thu, 7 Feb 2002 10:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289646AbSBGPle>; Thu, 7 Feb 2002 10:41:34 -0500
Received: from real.realitydiluted.com ([208.242.241.164]:41642 "EHLO
	real.realitydiluted.com") by vger.kernel.org with ESMTP
	id <S289581AbSBGPlN>; Thu, 7 Feb 2002 10:41:13 -0500
Message-ID: <3C62A002.378B368A@cotw.com>
Date: Thu, 07 Feb 2002 09:40:50 -0600
From: "Steven J. Hill" <sjhill@cotw.com>
Reply-To: sjhill@cotw.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-xfs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, pci-ids@ucw.cz
Subject: [PATCH] Eliminate trigraph warning from 'pci.ids'...
Content-Type: multipart/mixed;
 boundary="------------9FB45BDEC3656E8C542AA769"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------9FB45BDEC3656E8C542AA769
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Just a patch to eliminate a compiler warning caused by (??) and (???)
appearing in the generated file 'drivers/pci/devlist.h'. Please apply.

-Steve

-- 
 Steven J. Hill - Embedded SW Engineer
--------------9FB45BDEC3656E8C542AA769
Content-Type: application/octet-stream;
 name="pci.ids.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="pci.ids.diff"

LS0tIHBjaS5pZHMJVGh1IEZlYiAgNyAwOTozNjoyOSAyMDAyCisrKyBwY2kuaWRzLm5ldwlU
aHUgRmViICA3IDA5OjM0OjE5IDIwMDIKQEAgLTEzOTIsNyArMTM5Miw3IEBACiAxMDllICBC
cm9va3RyZWUgQ29ycG9yYXRpb24KIAkwMzUwICBCdDg0OCBUViB3aXRoIERNQSBwdXNoCiAJ
MDM1MSAgQnQ4NDlBIFZpZGVvIGNhcHR1cmUKLQkwMzZjICBCdDg3OSg/PykgVmlkZW8gQ2Fw
dHVyZQorCTAzNmMgIEJ0ODc5Wz8/XSBWaWRlbyBDYXB0dXJlCiAJCTEzZTkgMDA3MCAgV2lu
L1RWIChWaWRlbyBTZWN0aW9uKQogCTAzNmUgIEJ0ODc4CiAJCTAwNzAgMTNlYiAgV2luVFYv
R08KQEAgLTQ2NTYsNyArNDY1Niw3IEBACiAyNzBiICBYYW50ZWwgQ29ycG9yYXRpb24KIDI3
MGYgIENoYWludGVjaCBDb21wdXRlciBDby4gTHRkCiAyNzExICBBVklEIFRlY2hub2xvZ3kg
SW5jLgotMmExNSAgM0QgVmlzaW9uKD8/PykKKzJhMTUgIDNEIFZpc2lvbls/Pz9dCiAzMDAw
ICBIYW5zb2wgRWxlY3Ryb25pY3MgSW5jLgogMzE0MiAgUG9zdCBJbXByZXNzaW9uIFN5c3Rl
bXMuCiAzMzg4ICBIaW50IENvcnAK
--------------9FB45BDEC3656E8C542AA769--

