Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262258AbTENR7S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 13:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262351AbTENR7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 13:59:18 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:31994 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP id S262258AbTENR7R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 13:59:17 -0400
Message-ID: <3EC28938.8010402@attbi.com>
Date: Wed, 14 May 2003 14:21:44 -0400
From: "George G. Davis" <davis_g@attbi.com>
Reply-To: davis_g@attbi.com, davis_g@attbi.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021128
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Trivial fix for get_user undefined in linux-2.4.20 wdt977
 kernel module
Content-Type: multipart/mixed;
 boundary="------------060200070208040301060607"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060200070208040301060607
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Greetings,

The attached patch fixes get_user undefined in linux-2.4.20 wdt977
kernel module.

--
Regards,
George


--------------060200070208040301060607
Content-Type: text/plain;
 name="patch-2.4.20-drivers_char_wdt977"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="patch-2.4.20-drivers_char_wdt977"

LS0tIGxpbnV4LTIuNC4yMC1vcmlnL2RyaXZlcnMvY2hhci93ZHQ5NzcuYwlUdWUgRGVjIDEw
IDE2OjAyOjA4IDIwMDIKKysrIGxpbnV4LTIuNC4yMC1uZXcvZHJpdmVycy9jaGFyL3dkdDk3
Ny5jCVdlZCBNYXkgMTQgMTE6NDA6MDggMjAwMwpAQCAtMjcsNiArMjcsNyBAQAogI2luY2x1
ZGUgPGFzbS9pby5oPgogI2luY2x1ZGUgPGFzbS9zeXN0ZW0uaD4KICNpbmNsdWRlIDxhc20v
bWFjaC10eXBlcy5oPgorI2luY2x1ZGUgPGFzbS91YWNjZXNzLmg+CiAKICNkZWZpbmUgV0FU
Q0hET0dfTUlOT1IJMTMwCiAK
--------------060200070208040301060607--

