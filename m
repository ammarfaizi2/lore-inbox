Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262357AbUJ0JnC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262357AbUJ0JnC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 05:43:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262354AbUJ0JnC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 05:43:02 -0400
Received: from fep02.ttnet.net.tr ([212.156.4.131]:39416 "EHLO
	fep02.ttnet.net.tr") by vger.kernel.org with ESMTP id S262357AbUJ0JmT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 05:42:19 -0400
X-Mailer: Openwave WebEngine, version 2.8.11 (webedge20-101-194-20030622)
From: <sezeroz@ttnet.net.tr>
To: <linux-kernel@vger.kernel.org>
CC: <marcelo.tosatti@cyclades.com>
Subject: 2.4.28-rc1, more lost patches [6/10]
Date: Wed, 27 Oct 2004 12:40:36 +0300
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=____1098870036508_,C8O_cwrG'"
Message-Id: <20041027094036.KAGS6935.fep01.ttnet.net.tr@localhost>
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=____1098870036508_,C8O_cwrG'
Content-Type: text/plain;
	charset=ISO-8859-9
Content-Transfer-Encoding: 7bit


[6/10] cdrom: If the device is opened O_EXCL but there are
other openers, return busy. From ac/redhat. (by Arjan??)


------=____1098870036508_,C8O_cwrG'
Content-Transfer-Encoding: base64
Content-Type: application/octet-stream;
	name="cdrom-O_EXCL.patch"
Content-Disposition: inline;
	filename="cdrom-O_EXCL.patch"

CmZyb20gLWFjIC8gcmVkaGF0CmxvY2F0aW9uIG9mIGNvZGUgbW92ZWQgdXB3YXJkcyBhIGJpdAoK
ZGlmZiAtdXJOIDI4cmMxL2RyaXZlcnMvY2Ryb20vY2Ryb20uYyAyOHJjMV9hYWMvZHJpdmVycy9j
ZHJvbS9jZHJvbS5jCi0tLSAyOHJjMS9kcml2ZXJzL2Nkcm9tL2Nkcm9tLmMJMjAwMy0xMS0yOCAy
MDoyNjoyMC4wMDAwMDAwMDAgKzAyMDAKKysrIDI4cmMxX2FhYy9kcml2ZXJzL2Nkcm9tL2Nkcm9t
LmMJMjAwNC0xMC0yNCAwMDo1ODowOS4wMDAwMDAwMDAgKzAzMDAKQEAgLTQ2NSw2ICs0NjUsMTAg
QEAKIAlpZiAoKGNkaSA9IGNkcm9tX2ZpbmRfZGV2aWNlKGRldikpID09IE5VTEwpCiAJCXJldHVy
biAtRU5PREVWOwogCisJLyogSWYgdGhlIGRldmljZSBpcyBvcGVuZWQgT19FWENMIGJ1dCB0aGVy
ZSBhcmUgb3RoZXIgb3BlbmVycywgcmV0dXJuIGJ1c3kgKi8KKwlpZiAoIChmcC0+Zl9mbGFncyAm
IE9fRVhDTCkgJiYgKGNkaS0+dXNlX2NvdW50PjApICkKKwkJcmV0dXJuIC1FQlVTWTsKKwogCWlm
ICgoZnAtPmZfbW9kZSAmIEZNT0RFX1dSSVRFKSAmJiAhQ0RST01fQ0FOKENEQ19EVkRfUkFNKSkK
IAkJcmV0dXJuIC1FUk9GUzsKIAo=

------=____1098870036508_,C8O_cwrG'--
