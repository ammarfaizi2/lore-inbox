Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261637AbSJJPzx>; Thu, 10 Oct 2002 11:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261636AbSJJPzx>; Thu, 10 Oct 2002 11:55:53 -0400
Received: from email.gcom.com ([206.221.230.194]:28346 "EHLO gcom.com")
	by vger.kernel.org with ESMTP id <S261634AbSJJPzu>;
	Thu, 10 Oct 2002 11:55:50 -0400
Message-Id: <5.1.0.14.2.20021010105918.026a55f8@localhost>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 10 Oct 2002 11:01:14 -0500
To: bidulock@openss7.org, Petr Vandrovec <VANDROVE@vc.cvut.cz>
From: David Grothe <dave@gcom.com>
Subject: Re: [Linux-streams] Re: [PATCH] Re: export of sys_call_table
Cc: linux-kernel@vger.kernel.org, LiS <linux-streams@gsyc.escet.urjc.es>,
       davem@redhat.com
In-Reply-To: <20021009135442.E16773@openss7.org>
References: <41C1FEE0A55@vcnet.vc.cvut.cz>
 <41C1FEE0A55@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=====================_1707514646==_"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=====================_1707514646==_
Content-Type: text/plain; charset="us-ascii"; format=flowed

Brian, Petr, et al:

Does this patch address your suggestions?  This has been tested on 2.4.19.

Thanks,
Dave

At 01:54 PM 10/9/2002 Wednesday, Brian F. G. Bidulock wrote:
>Petr,
>
>Thanks you for the constructive suggestions.  I'll see if we
>can add those in an test it up.
>
>--brian

--=====================_1707514646==_
Content-Type: text/plain; name="stock-i386-2.4.19.txt";
 x-mac-type="42494E41"; x-mac-creator="74747874"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="stock-i386-2.4.19.txt"

LS0tIGFyY2gvaTM4Ni9rZXJuZWwvZW50cnkuUy5vcmlnCTIwMDItMDgtMDIgMTk6Mzk6NDIuMDAw
MDAwMDAwIC0wNTAwCisrKyBhcmNoL2kzODYva2VybmVsL2VudHJ5LlMJMjAwMi0xMC0wOCAxNTo0
MzowOC4wMDAwMDAwMDAgLTA1MDAKQEAgLTU4NCw4ICs1ODQsOCBAQAogCS5sb25nIFNZTUJPTF9O
QU1FKHN5c19jYXBzZXQpICAgICAgICAgICAvKiAxODUgKi8KIAkubG9uZyBTWU1CT0xfTkFNRShz
eXNfc2lnYWx0c3RhY2spCiAJLmxvbmcgU1lNQk9MX05BTUUoc3lzX3NlbmRmaWxlKQotCS5sb25n
IFNZTUJPTF9OQU1FKHN5c19uaV9zeXNjYWxsKQkJLyogc3RyZWFtczEgKi8KLQkubG9uZyBTWU1C
T0xfTkFNRShzeXNfbmlfc3lzY2FsbCkJCS8qIHN0cmVhbXMyICovCisJLmxvbmcgU1lNQk9MX05B
TUUoc3lzX2dldHBtc2cpCQkvKiBzdHJlYW1zMSAqLworCS5sb25nIFNZTUJPTF9OQU1FKHN5c19w
dXRwbXNnKQkJLyogc3RyZWFtczIgKi8KIAkubG9uZyBTWU1CT0xfTkFNRShzeXNfdmZvcmspICAg
ICAgICAgICAgLyogMTkwICovCiAJLmxvbmcgU1lNQk9MX05BTUUoc3lzX2dldHJsaW1pdCkKIAku
bG9uZyBTWU1CT0xfTkFNRShzeXNfbW1hcDIpCi0tLSBrZXJuZWwva3N5bXMuYy5vcmlnCTIwMDIt
MDgtMDIgMTk6Mzk6NDYuMDAwMDAwMDAwIC0wNTAwCisrKyBrZXJuZWwva3N5bXMuYwkyMDAyLTEw
LTEwIDEwOjQ2OjQzLjAwMDAwMDAwMCAtMDUwMApAQCAtNDk3LDYgKzQ5NywxMSBAQAogRVhQT1JU
X1NZTUJPTChzZXFfcmVsZWFzZSk7CiBFWFBPUlRfU1lNQk9MKHNlcV9yZWFkKTsKIEVYUE9SVF9T
WU1CT0woc2VxX2xzZWVrKTsKK2V4dGVybiBpbnQgcmVnaXN0ZXJfc3RyZWFtc19jYWxscyhpbnQg
KCpwdXRwbXNnKSAoaW50LHZvaWQgKix2b2lkICosaW50LGludCksCisJCQkJICAgaW50ICgqZ2V0
cG1zZykgKGludCx2b2lkICosdm9pZCAqLGludCxpbnQpKTsKK2V4dGVybiB2b2lkIHVucmVnaXN0
ZXJfc3RyZWFtc19jYWxscyh2b2lkKTsKK0VYUE9SVF9TWU1CT0wocmVnaXN0ZXJfc3RyZWFtc19j
YWxscyk7CitFWFBPUlRfU1lNQk9MKHVucmVnaXN0ZXJfc3RyZWFtc19jYWxscyk7CiAKIC8qIFBy
b2dyYW0gbG9hZGVyIGludGVyZmFjZXMgKi8KIEVYUE9SVF9TWU1CT0woc2V0dXBfYXJnX3BhZ2Vz
KTsKLS0tIGtlcm5lbC9zeXMuYy5vcmlnCTIwMDItMDgtMDIgMTk6Mzk6NDYuMDAwMDAwMDAwIC0w
NTAwCisrKyBrZXJuZWwvc3lzLmMJMjAwMi0xMC0xMCAxMDo1MToyNy4wMDAwMDAwMDAgLTA1MDAK
QEAgLTE2Nyw2ICsxNjcsNTAgQEAKIAlyZXR1cm4gbm90aWZpZXJfY2hhaW5fdW5yZWdpc3Rlcigm
cmVib290X25vdGlmaWVyX2xpc3QsIG5iKTsKIH0KIAorc3RhdGljIGludCAoKmRvX3B1dHBtc2cp
IChpbnQsIHZvaWQgKiwgdm9pZCAqLCBpbnQsIGludCkgPSBOVUxMOworc3RhdGljIGludCAoKmRv
X2dldHBtc2cpIChpbnQsIHZvaWQgKiwgdm9pZCAqLCBpbnQsIGludCkgPSBOVUxMOworCitzdGF0
aWMgREVDTEFSRV9SV1NFTShzdHJlYW1zX2NhbGxfc2VtKSA7CisKK2xvbmcgYXNtbGlua2FnZSBz
eXNfcHV0cG1zZyhpbnQgZmQsIHZvaWQgKmN0bHB0ciwgdm9pZCAqZGF0cHRyLCBpbnQgYmFuZCwg
aW50IGZsYWdzKQoreworCWludCByZXQgPSAtRU5PU1lTOworCWRvd25fcmVhZCgmc3RyZWFtc19j
YWxsX3NlbSkgOwkvKiBzaG91bGQgcmV0dXJuIGludCwgYnV0IGRvZXNuJ3QgKi8KKwlpZiAoZG9f
cHV0cG1zZykKKwkJcmV0ID0gKCpkb19wdXRwbXNnKSAoZmQsIGN0bHB0ciwgZGF0cHRyLCBiYW5k
LCBmbGFncyk7CisJdXBfcmVhZCgmc3RyZWFtc19jYWxsX3NlbSk7CisJcmV0dXJuIHJldDsKK30K
KworbG9uZyBhc21saW5rYWdlIHN5c19nZXRwbXNnKGludCBmZCwgdm9pZCAqY3RscHRyLCB2b2lk
ICpkYXRwdHIsIGludCBiYW5kLCBpbnQgZmxhZ3MpCit7CisJaW50IHJldCA9IC1FTk9TWVM7CisJ
ZG93bl9yZWFkKCZzdHJlYW1zX2NhbGxfc2VtKSA7CS8qIHNob3VsZCByZXR1cm4gaW50LCBidXQg
ZG9lc24ndCAqLworCWlmIChkb19nZXRwbXNnKQorCQlyZXQgPSAoKmRvX2dldHBtc2cpIChmZCwg
Y3RscHRyLCBkYXRwdHIsIGJhbmQsIGZsYWdzKTsKKwl1cF9yZWFkKCZzdHJlYW1zX2NhbGxfc2Vt
KTsKKwlyZXR1cm4gcmV0OworfQorCitpbnQgcmVnaXN0ZXJfc3RyZWFtc19jYWxscyhpbnQgKCpw
dXRwbXNnKSAoaW50LCB2b2lkICosIHZvaWQgKiwgaW50LCBpbnQpLAorCQkJICAgIGludCAoKmdl
dHBtc2cpIChpbnQsIHZvaWQgKiwgdm9pZCAqLCBpbnQsIGludCkpCit7CisJZG93bl93cml0ZSgm
c3RyZWFtc19jYWxsX3NlbSkgOwkvKiBzaG91bGQgcmV0dXJuIGludCwgYnV0IGRvZXNuJ3QgKi8K
KwlpZiAoICAgKHB1dHBtc2cgIT0gTlVMTCAmJiBkb19wdXRwbXNnICE9IE5VTEwpCisJICAgIHx8
IChnZXRwbXNnICE9IE5VTEwgJiYgZG9fZ2V0cG1zZyAhPSBOVUxMKQorCSAgICkKKwkJcmV0dXJu
IC1FQlVTWTsKKwlkb19wdXRwbXNnID0gcHV0cG1zZzsKKwlkb19nZXRwbXNnID0gZ2V0cG1zZzsK
Kwl1cF93cml0ZSgmc3RyZWFtc19jYWxsX3NlbSk7CisJcmV0dXJuIDAgOworfQorCit2b2lkIHVu
cmVnaXN0ZXJfc3RyZWFtc19jYWxscyh2b2lkKQoreworCXJlZ2lzdGVyX3N0cmVhbXNfY2FsbHMo
TlVMTCwgTlVMTCk7Cit9CisKIGFzbWxpbmthZ2UgbG9uZyBzeXNfbmlfc3lzY2FsbCh2b2lkKQog
ewogCXJldHVybiAtRU5PU1lTOwo=
--=====================_1707514646==_--

