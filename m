Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269003AbUJKSqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269003AbUJKSqu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 14:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269173AbUJKSqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 14:46:50 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:47514 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S269003AbUJKSoD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 14:44:03 -0400
Message-ID: <416AD472.5050909@free.fr>
Date: Mon, 11 Oct 2004 20:44:02 +0200
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: bttv maintainers
Content-Type: multipart/mixed;
 boundary="------------070602020305040108050504"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070602020305040108050504
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi the email adress in MAINTAINERS is right ?
I send 3 mail to kraxel@bytesex.org but I have no reply (the first one 
was send 5 day ago).

The fist to problem irq fixes and fix read pb seem to the solve in cvs.
The last one explain a bug describe here : 
http://sourceforge.net/forum/forum.php?thread_id=1156319&forum_id=217872

I attach the patch that solve the problem.

Signed-Off-By: Matthieu Castet <castet.matthieu@free.fr>

--------------070602020305040108050504
Content-Type: text/plain;
 name="t"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="t"

LS0tIGxpbnV4LTIuNi44LjEvZHJpdmVycy9tZWRpYS92aWRlby9idHR2LWRyaXZlci5jb2xk
CTIwMDQtMTAtMDkgMjE6MTc6MzQuMDAwMDAwMDAwICswMjAwCisrKyBsaW51eC0yLjYuOC4x
L2RyaXZlcnMvbWVkaWEvdmlkZW8vYnR0di1kcml2ZXIuYwkyMDA0LTEwLTA5IDIxOjIwOjQy
LjAwMDAwMDAwMCArMDIwMApAQCAtMTU2OCw2ICsxNTY4LDcgQEAKIAkJCXJldHVybiAwOwog
CQl9CiAKKwkJYnR0dl9jYWxsX2kyY19jbGllbnRzKGJ0dixjbWQsdik7CiAJCWJ0di0+dHZu
b3JtID0gdi0+bm9ybTsKIAkJc2V0X2lucHV0KGJ0dix2LT5jaGFubmVsKTsKIAkJdXAoJmJ0
di0+bG9jayk7Cg==
--------------070602020305040108050504--
