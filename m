Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932600AbWHDLd2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932600AbWHDLd2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 07:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932599AbWHDLd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 07:33:28 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:54448 "EHLO
	out4.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S932596AbWHDLd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 07:33:28 -0400
Message-Id: <1154691206.14227.267630051@webmail.messagingengine.com>
X-Sasl-Enc: Om3FPsVG+FQQmY2AdBNJ+YrFBG+uTmChq+ovNg9EBSjE 1154691206
From: "Komal Shah" <komal_shah802003@yahoo.com>
To: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: jzhang@ti.com, david-b@pacbell.net, dwmw2@infradead.org, tony@atomide.com
Content-Transfer-Encoding: 7bit
Content-Type: multipart/mixed; boundary="_----------=_1154691206142270"; charset="ISO-8859-1"
MIME-Version: 1.0
X-Mailer: MessagingEngine.com Webmail Interface
Subject: [PATCH] OMAP: Add TI OMAP242x H4 EVM NOR flash support.
Date: Fri, 04 Aug 2006 17:03:26 +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--_----------=_1154691206142270
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
X-Mailer: MessagingEngine.com Webmail Interface
Date: Fri, 4 Aug 2006 11:33:26 UT

Attached patch adds support for TI OMAP242x based H4 EVM
board NOR flash support.

Please review it and give the ack if it is OK.

PS:
Trying lkml this time, as my e-mail id is not considered "good" for linux-mtd :(

---Komal Shah
http://komalshah.blogspot.com

-- 
http://www.fastmail.fm - The way an email service should be


--_----------=_1154691206142270
Content-Disposition: attachment; filename="0001-OMAP-Add-TI-OMAP242x-NOR-Flash.patch"
Content-Transfer-Encoding: base64
Content-Type: application/octet-stream; name="0001-OMAP-Add-TI-OMAP242x-NOR-Flash.patch"
MIME-Version: 1.0
X-Mailer: MessagingEngine.com Webmail Interface
Date: Fri, 4 Aug 2006 11:33:26 UT

RnJvbSBub2JvZHkgTW9uIFNlcCAxNyAwMDowMDowMCAyMDAxCkZyb206IEtv
bWFsIFNoYWggPGtvbWFsX3NoYWg4MDIwMDNAeWFob28uY29tPgpEYXRlOiBU
dWUsIDI1IEp1bCAyMDA2IDIyOjI2OjA1ICswNTMwClN1YmplY3Q6IFtQQVRD
SF0gT01BUDogQWRkIFRJIE9NQVAyNDJ4IEg0IEVWTSBOT1IgZmxhc2ggc3Vw
cG9ydC4KClBhdGNoIGFkZHMgc3VwcG9ydCBmb3IgVEkgT01BUDI0MnggKGh0
dHA6Ly93d3cudGkuY29tL29tYXApCkg0IEVWTSBOT1IgRmxhc2ggc3VwcG9y
dC4KClNpZ25lZC1vZmYtYnk6IEtvbWFsIFNoYWggPGtvbWFsX3NoYWg4MDIw
MDNAeWFob28uY29tPgoKLS0tCgogZHJpdmVycy9tdGQvbWFwcy9vbWFwX25v
ci5jIHwgICAxNCArKysrKysrKy0tLS0tLQogMSBmaWxlcyBjaGFuZ2VkLCA4
IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCgo3OTkzZWJlNTliMGE0
ZGM4ZmMxYzhkZGMzOTkwNGUwZDVlYjFiZTljCmRpZmYgLS1naXQgYS9kcml2
ZXJzL210ZC9tYXBzL29tYXBfbm9yLmMgYi9kcml2ZXJzL210ZC9tYXBzL29t
YXBfbm9yLmMKaW5kZXggNDE4YWZmZi4uYTZlNzA1ZiAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9tdGQvbWFwcy9vbWFwX25vci5jCisrKyBiL2RyaXZlcnMvbXRk
L21hcHMvb21hcF9ub3IuYwpAQCAtNjEsMTIgKzYxLDE0IEBAIHN0YXRpYyB2
b2lkIG9tYXBfc2V0X3ZwcChzdHJ1Y3QgbWFwX2luZm8KIHsKIAlzdGF0aWMg
aW50CWNvdW50OwogCi0JaWYgKGVuYWJsZSkgewotCQlpZiAoY291bnQrKyA9
PSAwKQotCQkJT01BUF9FTUlGU19DT05GSUdfUkVHIHw9IE9NQVBfRU1JRlNf
Q09ORklHX1dQOwotCX0gZWxzZSB7Ci0JCWlmIChjb3VudCAmJiAoLS1jb3Vu
dCA9PSAwKSkKLQkJCU9NQVBfRU1JRlNfQ09ORklHX1JFRyAmPSB+T01BUF9F
TUlGU19DT05GSUdfV1A7CisJaWYgKCFjcHVfaXNfb21hcDI0eHgoKSkgewor
CQlpZiAoZW5hYmxlKSB7CisJCQlpZiAoY291bnQrKyA9PSAwKQorCQkJCU9N
QVBfRU1JRlNfQ09ORklHX1JFRyB8PSBPTUFQX0VNSUZTX0NPTkZJR19XUDsK
KwkJfSBlbHNlIHsKKwkJCWlmIChjb3VudCAmJiAoLS1jb3VudCA9PSAwKSkK
KwkJCQlPTUFQX0VNSUZTX0NPTkZJR19SRUcgJj0gfk9NQVBfRU1JRlNfQ09O
RklHX1dQOworCQl9CiAJfQogfQogCi0tIAoxLjMuMwoK

--_----------=_1154691206142270--

