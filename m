Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbWGVIuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWGVIuW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 04:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbWGVIuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 04:50:22 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:25054 "EHLO
	out4.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1750701AbWGVIuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 04:50:21 -0400
Message-Id: <1153558221.6197.266618246@webmail.messagingengine.com>
X-Sasl-Enc: 2uSlSHYG/KrKMmT4wdir/e7E3FDCg8qV3SNY632p6/3r 1153558221
From: "Komal Shah" <komal_shah802003@yahoo.com>
To: linux-kernel@vger.kernel.org, gregkh@suse.de, nico@cam.org
Cc: tony@atomide.com
Content-Transfer-Encoding: 7bit
Content-Type: multipart/mixed; boundary="_----------=_115355822161970"; charset="ISO-8859-1"
MIME-Version: 1.0
X-Mailer: MessagingEngine.com Webmail Interface
Subject: [PATCH] OMAP: Add smc91x support for TI OMAP2420 H4 board.
Date: Sat, 22 Jul 2006 01:50:21 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--_----------=_115355822161970
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
X-Mailer: MessagingEngine.com Webmail Interface
Date: Sat, 22 Jul 2006 08:50:21 UT

Greg/Nico,

Attached patch adds smc91x support for TI OMAP2420 H4 EVM board.

---Komal Shah
http://komalshah.blogspot.com

-- 
http://www.fastmail.fm - Choose from over 50 domains or use your own


--_----------=_115355822161970
Content-Disposition: attachment; filename="0001-h4-smc91x.patch"
Content-Transfer-Encoding: base64
Content-Type: application/octet-stream; name="0001-h4-smc91x.patch"
MIME-Version: 1.0
X-Mailer: MessagingEngine.com Webmail Interface
Date: Sat, 22 Jul 2006 08:50:21 UT

RnJvbSBub2JvZHkgTW9uIFNlcCAxNyAwMDowMDowMCAyMDAxCkZyb206IEtv
bWFsIFNoYWggPGtvbWFsX3NoYWg4MDIwMDNAeWFob28uY29tPgpEYXRlOiBU
dWUsIDIwIEp1biAyMDA2IDAxOjIyOjEzICswNTMwClN1YmplY3Q6IFtQQVRD
SF0gQWRkIHNtYzkxeCBzdXBwb3J0IGZvciBUSSBPTUFQMjQyMCBINCBib2Fy
ZC4KClNpZ25lZC1vZmYtYnk6IEtvbWFsIFNoYWggPGtvbWFsX3NoYWg4MDIw
MDNAeWFob28uY29tPgoKLS0tCgogZHJpdmVycy9uZXQvc21jOTF4LmggfCAg
ICAxICsKIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAwIGRl
bGV0aW9ucygtKQoKMmFkZjViNjljYzFlZDRhNTE2OTVmNDkwOTAzZmVkMmM5
ZmU1ODA0OApkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvc21jOTF4LmggYi9k
cml2ZXJzL25ldC9zbWM5MXguaAppbmRleCA0ZWM0YjRkLi4wMGFjZThhIDEw
MDY0NAotLS0gYS9kcml2ZXJzL25ldC9zbWM5MXguaAorKysgYi9kcml2ZXJz
L25ldC9zbWM5MXguaApAQCAtMjA2LDYgKzIwNiw3IEBAICNpbmNsdWRlIDxh
c20vYXJjaC9jcHUuaD4KICNkZWZpbmUJU01DX0lSUV9GTEFHUyAoKCBcCiAJ
CSAgIG1hY2hpbmVfaXNfb21hcF9oMigpIFwKIAkJfHwgbWFjaGluZV9pc19v
bWFwX2gzKCkgXAorCQl8fCBtYWNoaW5lX2lzX29tYXBfaDQoKSBcCiAJCXx8
IChtYWNoaW5lX2lzX29tYXBfaW5ub3ZhdG9yKCkgJiYgIWNwdV9pc19vbWFw
MTUxMCgpKSBcCiAJKSA/IElSUUZfVFJJR0dFUl9GQUxMSU5HIDogSVJRRl9U
UklHR0VSX1JJU0lORykKIAotLSAKMS4zLjMKCg==

--_----------=_115355822161970--

