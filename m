Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262170AbRGEU6o>; Thu, 5 Jul 2001 16:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263793AbRGEU6f>; Thu, 5 Jul 2001 16:58:35 -0400
Received: from sncgw.nai.com ([161.69.248.229]:51593 "EHLO mcafee-labs.nai.com")
	by vger.kernel.org with ESMTP id <S262170AbRGEU6V>;
	Thu, 5 Jul 2001 16:58:21 -0400
Message-ID: <XFMail.20010705135733.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_=XFMail.1.4.7.Linux:20010705135733:704=_"
Date: Thu, 05 Jul 2001 13:57:33 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: linux-kernel@vger.kernel.org
Subject: linux/macros.h(new) and linux/list.h(mod) ...
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format
--_=XFMail.1.4.7.Linux:20010705135733:704=_
Content-Type: text/plain; charset=us-ascii


This patch add a new linux/macros.h that is supposed to host utility macros
that otherwise developers are forced to define in their files.
This version contain only min(), max() and abs().
The other change is to linux/list.h by adding two members list_first() and
list_last().




- Davide


--_=XFMail.1.4.7.Linux:20010705135733:704=_
Content-Disposition: attachment; filename="misc.diff"
Content-Transfer-Encoding: base64
Content-Description: misc.diff
Content-Type: application/octet-stream; name=misc.diff; SizeOnDisk=1077

ZGlmZiAtTkJicnUgbGludXgtMi40LjYudmFuaWxsYS9pbmNsdWRlL2xpbnV4L2xpc3QuaCBsaW51
eC0yLjQuNi9pbmNsdWRlL2xpbnV4L2xpc3QuaAotLS0gbGludXgtMi40LjYudmFuaWxsYS9pbmNs
dWRlL2xpbnV4L2xpc3QuaAlGcmkgRmViIDE2IDE2OjA2OjE3IDIwMDEKKysrIGxpbnV4LTIuNC42
L2luY2x1ZGUvbGludXgvbGlzdC5oCU1vbiBKdWwgIDIgMTY6MTQ6MjcgMjAwMQpAQCAtMTQ4LDYg
KzE0OCwxMCBAQAogICovCiAjZGVmaW5lIGxpc3RfZm9yX2VhY2gocG9zLCBoZWFkKSBcCiAJZm9y
IChwb3MgPSAoaGVhZCktPm5leHQ7IHBvcyAhPSAoaGVhZCk7IHBvcyA9IHBvcy0+bmV4dCkKKwor
I2RlZmluZSBsaXN0X2ZpcnN0KGhlYWQpCSgoKGhlYWQpLT5uZXh0ICE9IChoZWFkKSkgPyAoaGVh
ZCktPm5leHQ6IChzdHJ1Y3QgbGlzdF9oZWFkICopIDApCisKKyNkZWZpbmUgbGlzdF9sYXN0KGhl
YWQpCSgoKGhlYWQpLT5wcmV2ICE9IChoZWFkKSkgPyAoaGVhZCktPnByZXY6IChzdHJ1Y3QgbGlz
dF9oZWFkICopIDApCgogI2VuZGlmIC8qIF9fS0VSTkVMX18gfHwgX0xWTV9IX0lOQ0xVREUgKi8K
CmRpZmYgLU5CYnJ1IGxpbnV4LTIuNC42LnZhbmlsbGEvaW5jbHVkZS9saW51eC9tYWNyb3MuaCBs
aW51eC0yLjQuNi9pbmNsdWRlL2xpbnV4L21hY3Jvcy5oCi0tLSBsaW51eC0yLjQuNi52YW5pbGxh
L2luY2x1ZGUvbGludXgvbWFjcm9zLmgJV2VkIERlYyAzMSAxNjowMDowMCAxOTY5CisrKyBsaW51
eC0yLjQuNi9pbmNsdWRlL2xpbnV4L21hY3Jvcy5oCVdlZCBKdWwgIDQgMTY6NDE6MzEgMjAwMQpA
QCAtMCwwICsxLDE5IEBACisjaWZuZGVmIF9MSU5VWF9NQUNST1NfSAorI2RlZmluZSBfTElOVVhf
TUFDUk9TX0gKKworCisjaWZuZGVmIG1pbgorI2RlZmluZSBtaW4oYSwgYikJKCgoYSkgPCAoYikp
ID8gKGEpOiAoYikpCisjZW5kaWYKKworI2lmbmRlZiBtYXgKKyNkZWZpbmUgbWF4KGEsIGIpCSgo
KGEpID4gKGIpKSA/IChhKTogKGIpKQorI2VuZGlmCisKKyNpZm5kZWYgYWJzCisjZGVmaW5lIGFi
cyhhKQkoKChhKSA+IDApID8gKGEpOiAtKGEpKQorI2VuZGlmCisKKworCisjZW5kaWYK

--_=XFMail.1.4.7.Linux:20010705135733:704=_--
End of MIME message
