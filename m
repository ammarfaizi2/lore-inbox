Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261446AbSLAFDQ>; Sun, 1 Dec 2002 00:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261450AbSLAFDQ>; Sun, 1 Dec 2002 00:03:16 -0500
Received: from [211.167.76.68] ([211.167.76.68]:20921 "HELO soulinfo")
	by vger.kernel.org with SMTP id <S261446AbSLAFDP>;
	Sun, 1 Dec 2002 00:03:15 -0500
Date: Sun, 1 Dec 2002 13:04:27 +0800
From: hugang <hugang@soulinfo.com>
To: linux-kernel@vger.kernel.org, Andrea Arcangeli <andrea@suse.de>,
       "J.A. Magallon" <jamagallon@able.es>,
       Marcelo Tosatti <marcelo@hera.kernel.org>
Subject: [patch]back ports ICH3M support into 2.4.20
Message-Id: <20021201130427.37a915bf.hugang@soulinfo.com>
X-Mailer: Sylpheed version 0.8.5claws126 (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Sun__1_Dec_2002_13:04:27_+0800_08af0d88"
=?ISO-8859-1?Q?=CA=D5=BC=FE=C8=CB=A3=BA: ?= linux-kernel@vger.kernel.org
=?ISO-8859-1?Q?=CA=D5=BC=FE=C8=CB=A3=BA: ?= Andrea Arcangeli <andrea@suse.de>
=?ISO-8859-1?Q?=CA=D5=BC=FE=C8=CB=A3=BA: ?=  "J.A. Magallon" <jamagallon@able.es>
=?ISO-8859-1?Q?=CA=D5=BC=FE=C8=CB=A3=BA: ?= Marcelo Tosatti <marcelo@hera.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Sun__1_Dec_2002_13:04:27_+0800_08af0d88
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

hello 
  Here is a back port patch for Intel ICH3M IDE support. It's more stable for me. Hope can merage into stable tree. thanks.


-- 
		- Hu Gang

--Multipart_Sun__1_Dec_2002_13:04:27_+0800_08af0d88
Content-Type: application/octet-stream;
 name="misc_tune"
Content-Disposition: attachment;
 filename="misc_tune"
Content-Transfer-Encoding: base64

ZGlmZiAtdSAyLjQvZHJpdmVycy9pZGUvaWRlLXBjaS5jOjEuMS4xLjUgMi40L2RyaXZlcnMvaWRl
L2lkZS1wY2kuYzoxLjEuMS41LjguMgotLS0gMi40L2RyaXZlcnMvaWRlL2lkZS1wY2kuYzoxLjEu
MS41CUZyaSBOb3YgMjkgMTM6NTc6MzMgMjAwMgorKysgMi40L2RyaXZlcnMvaWRlL2lkZS1wY2ku
YwlTdW4gRGVjICAxIDEyOjUwOjQ0IDIwMDIKQEAgLTk2NCw2ICs5NjQsNDEgQEAKIAlpZGVfc2V0
dXBfcGNpX2RldmljZShkZXYyLCBkMik7CiB9CiAKK2lubGluZSB2b2lkIGlkZV9yZWdpc3Rlcl94
cF9maXgoc3RydWN0IHBjaV9kZXYgKmRldikKK3sKKyAgICAgICAgaW50IGk7CisgICAgICAgIHVu
c2lnbmVkIHNob3J0IGNtZDsKKyAgICAgICAgdW5zaWduZWQgbG9uZyBmbGFnczsKKyAgICAgICAg
dW5zaWduZWQgbG9uZyBiYXNlX2FkZHJlc3NbNF0gPSB7IDB4MWYwLCAweDNmNCwgMHgxNzAsIDB4
Mzc0IH07CisJCisgICAgICAgIGxvY2FsX2lycV9zYXZlKGZsYWdzKTsKKyAgICAgICAgcGNpX3Jl
YWRfY29uZmlnX3dvcmQoZGV2LCBQQ0lfQ09NTUFORCwgJmNtZCk7CisgICAgICAgIHBjaV93cml0
ZV9jb25maWdfd29yZChkZXYsIFBDSV9DT01NQU5ELCBjbWQgJiB+UENJX0NPTU1BTkRfSU8pOwor
ICAgICAgICBmb3IgKGk9MDsgaTw0OyBpKyspIHsKKyAgICAgICAgICAgICAgICBkZXYtPnJlc291
cmNlW2ldLnN0YXJ0ID0gMDsKKyAgICAgICAgICAgICAgICBkZXYtPnJlc291cmNlW2ldLmVuZCA9
IDA7CisgICAgICAgICAgICAgICAgZGV2LT5yZXNvdXJjZVtpXS5mbGFncyA9IDA7CisgICAgICAg
IH0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAKKyAgICAgICAgZm9yIChpPTA7IGk8NDsgaSsrKSB7ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAorICAgICAgICAgICAg
ICAgIGRldi0+cmVzb3VyY2VbaV0uc3RhcnQgPSBiYXNlX2FkZHJlc3NbaV07CisgICAgICAgICAg
ICAgICAgZGV2LT5yZXNvdXJjZVtpXS5mbGFncyB8PSBQQ0lfQkFTRV9BRERSRVNTX1NQQUNFX0lP
OworICAgICAgICAgICAgICAgIHBjaV93cml0ZV9jb25maWdfZHdvcmQoZGV2LAorCQkJCSAgICAg
ICAoUENJX0JBU0VfQUREUkVTU18wICsgKGkgKiA0KSksCisJCQkJICAgICAgIGRldi0+cmVzb3Vy
Y2VbaV0uc3RhcnQpOworICAgICAgICB9CisgICAgICAgIHBjaV93cml0ZV9jb25maWdfd29yZChk
ZXYsIFBDSV9DT01NQU5ELCBjbWQpOworICAgICAgICBsb2NhbF9pcnFfcmVzdG9yZShmbGFncyk7
Cit9CisKK3ZvaWQgX19pbml0IGZpeHVwX2RldmljZV9waWl4IChzdHJ1Y3QgcGNpX2RldiAqZGV2
LCBpZGVfcGNpX2RldmljZV90ICpkKQoreworICAgICAgICBpZiAoZGV2LT5yZXNvdXJjZVswXS5z
dGFydCAhPSAweDAxRjEpCisgICAgICAgICAgICAgICAgaWRlX3JlZ2lzdGVyX3hwX2ZpeChkZXYp
OworICAgICAgICBwcmludGsoIiVzOiBJREUgY29udHJvbGxlciBvbiBQQ0kgYnVzICUwMnggZGV2
ICUwMnhcbiIsCisJICAgICAgIGQtPm5hbWUsIGRldi0+YnVzLT5udW1iZXIsIGRldi0+ZGV2Zm4p
OworICAgICAgICBpZGVfc2V0dXBfcGNpX2RldmljZShkZXYsIGQpOworfQorCiAvKgogICogaWRl
X3NjYW5fcGNpYnVzKCkgZ2V0cyBpbnZva2VkIGF0IGJvb3QgdGltZSBmcm9tIGlkZS5jLgogICog
SXQgZmluZHMgYWxsIFBDSSBJREUgY29udHJvbGxlcnMgYW5kIGNhbGxzIGlkZV9zZXR1cF9wY2lf
ZGV2aWNlIGZvciB0aGVtLgpAQCAtOTkwLDYgKzEwMjUsOCBAQAogCQlocHQzNjZfZGV2aWNlX29y
ZGVyX2ZpeHVwKGRldiwgZCk7CiAJZWxzZSBpZiAoSURFX1BDSV9ERVZJRF9FUShkLT5kZXZpZCwg
REVWSURfUERDMjAyNzApKQogCQlwZGMyMDI3MF9kZXZpY2Vfb3JkZXJfZml4dXAoZGV2LCBkKTsK
KyAgICAgICAgZWxzZSBpZiAoSURFX1BDSV9ERVZJRF9FUShkLT5kZXZpZCwgREVWSURfSUNIM00p
KQorICAgICAgICAgICAgICAgIGZpeHVwX2RldmljZV9waWl4KGRldiwgZCk7CiAJZWxzZSBpZiAo
IUlERV9QQ0lfREVWSURfRVEoZC0+ZGV2aWQsIElERV9QQ0lfREVWSURfTlVMTCkgfHwgKGRldi0+
Y2xhc3MgPj4gOCkgPT0gUENJX0NMQVNTX1NUT1JBR0VfSURFKSB7CiAJCWlmIChJREVfUENJX0RF
VklEX0VRKGQtPmRldmlkLCBJREVfUENJX0RFVklEX05VTEwpKQogCQkJcHJpbnRrKCIlczogdW5r
bm93biBJREUgY29udHJvbGxlciBvbiBQQ0kgYnVzICUwMnggZGV2aWNlICUwMngsIFZJRD0lMDR4
LCBESUQ9JTA0eFxuIiwK

--Multipart_Sun__1_Dec_2002_13:04:27_+0800_08af0d88--
