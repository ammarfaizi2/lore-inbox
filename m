Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbVHVSlq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbVHVSlq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 14:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbVHVSlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 14:41:46 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:9934 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750780AbVHVSlp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 14:41:45 -0400
Message-ID: <430A45EA.6040506@labristeknoloji.com>
Date: Mon, 22 Aug 2005 21:38:50 +0000
From: "M.Baris Demiray" <baris@labristeknoloji.com>
Organization: Labris Teknoloji
User-Agent: Mozilla Thunderbird 1.0RC1 (X11/20041201)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Marcelo W. Tosatti" <marcelo.tosatti@cyclades.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4] Update PPPoE's configuration documentation
Content-Type: multipart/mixed;
 boundary="------------000006090408030500010202"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000006090408030500010202
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Hi Marcelo,
Following trivial patch updates the CONFIG_PPPOE options's
documentation.

o Update CONFIG_PPPOE option's documentation since ppp version
   2.4.2 is already released (with PPPoE plug-in) and there is
   no need a CVS checkout anymore

Signed-off-by: M.Baris Demiray <baris@labristeknoloji.com>

--- linux-2.4.32-pre3/Documentation/Configure.help.orig	2005-08-22 21:15:53.000000000 +0000
+++ linux-2.4.32-pre3/Documentation/Configure.help	2005-08-22 21:16:48.000000000 +0000
@@ -9978,9 +9978,7 @@
  CONFIG_PPPOE
    Support for PPP over Ethernet.

-  This driver requires the current pppd from the "ppp" CVS repository
-  on cvs.samba.org.  The required support will be present in the next
-  ppp release (2.4.2).
+  This driver requires a ppp release >=2.4.2

  Wireless LAN (non-hamradio)
  CONFIG_NET_RADIO

-- 
"You have to understand, most of these people are not ready to be
unplugged. And many of them are no inert, so hopelessly dependent
on the system, that they will fight to protect it."
                                                         Morpheus

--------------000006090408030500010202
Content-Type: text/x-vcard; charset=utf-8;
 name="baris.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="baris.vcf"

YmVnaW46dmNhcmQNCmZuOk0uQmFyaXMgRGVtaXJheQ0KbjpEZW1pcmF5O00uQmFyaXMNCm9y
ZzpMYWJyaXMgVGVrbm9sb2ppDQphZHI6OztUZWtub2tlbnQgU2lsaWtvbiBCaW5hIE5vOjI0
IE9EVFU7QW5rYXJhOzswNjUzMTtUdXJrZXkNCmVtYWlsO2ludGVybmV0OmJhcmlzQGxhYnJp
c3Rla25vbG9qaS5jb20NCnRpdGxlOllhemlsaW0gR2VsaXN0aXJtZSBVem1hbmkNCnRlbDt3
b3JrOis5MDMxMjIxMDE0OTANCnRlbDtmYXg6KzkwMzEyMjEwMTQ5Mg0KeC1tb3ppbGxhLWh0
bWw6RkFMU0UNCnVybDpodHRwOi8vd3d3LmxhYnJpc3Rla25vbG9qaS5jb20vfmJhcmlzLw0K
dmVyc2lvbjoyLjENCmVuZDp2Y2FyZA0KDQo=
--------------000006090408030500010202--
