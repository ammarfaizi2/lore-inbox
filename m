Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316821AbSGVLxC>; Mon, 22 Jul 2002 07:53:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316820AbSGVLxB>; Mon, 22 Jul 2002 07:53:01 -0400
Received: from gateway.cinet.co.jp ([210.166.75.129]:44156 "EHLO
	sakura.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S316821AbSGVLxA>; Mon, 22 Jul 2002 07:53:00 -0400
Message-ID: <3D3BF294.39BC26F6@cinet.co.jp>
Date: Mon, 22 Jul 2002 20:55:00 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
X-Mailer: Mozilla 4.79C-ja  [ja/Vine] (X11; U; Linux 2.4.19rc3-pc98 i586)
X-Accept-Language: ja
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.27 Logitech Busmouse new driver FIX
Content-Type: multipart/mixed;
 boundary="------------E61AAC8A99544FEB2E9BAD5F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E61AAC8A99544FEB2E9BAD5F
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit

Hi.
2.5.26-27 Logitech Busmouse driver doesn't work.
This patch fix it.
-- 
Osamu Tomita
E-mail: tomita@cinet.co.jp
--------------E61AAC8A99544FEB2E9BAD5F
Content-Type: application/octet-stream;
 name="linux-2.5.27-logibm.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="linux-2.5.27-logibm.patch"

LS0tIGxvZ2libS5jLkFUCVN1biBKdWwgMjEgMDQ6MTE6MjAgMjAwMgorKysgbG9naWJtLmMu
bGttbAlNb24gSnVsIDIyIDE2OjU4OjIyIDIwMDIKQEAgLTEyNSwxMyArMTI1LDE0IEBACiAJ
b3V0YihMT0dJQk1fUkVBRF9ZX0hJR0gsIExPR0lCTV9DT05UUk9MX1BPUlQpOwogCWJ1dHRv
bnMgPSBpbmIoTE9HSUJNX0RBVEFfUE9SVCk7CiAJZHkgfD0gKGJ1dHRvbnMgJiAweGYpIDw8
IDQ7Ci0JYnV0dG9ucyA9IH5idXR0b25zOworCWJ1dHRvbnMgPSB+YnV0dG9ucyA+PiA1Owog
CiAJaW5wdXRfcmVwb3J0X3JlbCgmbG9naWJtX2RldiwgUkVMX1gsIGR4KTsKLQlpbnB1dF9y
ZXBvcnRfcmVsKCZsb2dpYm1fZGV2LCBSRUxfWSwgMjU1IC0gZHkpOwotCWlucHV0X3JlcG9y
dF9rZXkoJmxvZ2libV9kZXYsIEJUTl9NSURETEUsIGJ1dHRvbnMgJiAxKTsKLQlpbnB1dF9y
ZXBvcnRfa2V5KCZsb2dpYm1fZGV2LCBCVE5fTEVGVCwgICBidXR0b25zICYgMik7Ci0JaW5w
dXRfcmVwb3J0X2tleSgmbG9naWJtX2RldiwgQlROX1JJR0hULCAgYnV0dG9ucyAmIDQpOwor
CWlucHV0X3JlcG9ydF9yZWwoJmxvZ2libV9kZXYsIFJFTF9ZLCBkeSk7CisJaW5wdXRfcmVw
b3J0X2tleSgmbG9naWJtX2RldiwgQlROX1JJR0hULCAgYnV0dG9ucyAmIDEpOworCWlucHV0
X3JlcG9ydF9rZXkoJmxvZ2libV9kZXYsIEJUTl9NSURETEUsIGJ1dHRvbnMgJiAyKTsKKwlp
bnB1dF9yZXBvcnRfa2V5KCZsb2dpYm1fZGV2LCBCVE5fTEVGVCwgICBidXR0b25zICYgNCk7
CisJb3V0YihMT0dJQk1fRU5BQkxFX0lSUSwgTE9HSUJNX0NPTlRST0xfUE9SVCk7CiB9CiAK
ICNpZm5kZWYgTU9EVUxFCkBAIC0xNDcsNyArMTQ4LDcgQEAKIAogc3RhdGljIGludCBfX2lu
aXQgbG9naWJtX2luaXQodm9pZCkKIHsKLQlpZiAocmVxdWVzdF9yZWdpb24oTE9HSUJNX0JB
U0UsIExPR0lCTV9FWFRFTlQsICJsb2dpYm0iKSkgeworCWlmICghcmVxdWVzdF9yZWdpb24o
TE9HSUJNX0JBU0UsIExPR0lCTV9FWFRFTlQsICJsb2dpYm0iKSkgewogCQlwcmludGsoS0VS
Tl9FUlIgImxvZ2libS5jOiBDYW4ndCBhbGxvY2F0ZSBwb3J0cyBhdCAlI3hcbiIsIExPR0lC
TV9CQVNFKTsKIAkJcmV0dXJuIC1FQlVTWTsKIAl9Cg==
--------------E61AAC8A99544FEB2E9BAD5F--

