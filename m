Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266972AbTAKBTp>; Fri, 10 Jan 2003 20:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266989AbTAKBTo>; Fri, 10 Jan 2003 20:19:44 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:9675 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266972AbTAKBTk>;
	Fri, 10 Jan 2003 20:19:40 -0500
Importance: Normal
Sensitivity: 
Subject: Re: [pthreads-devel] NGPT 2.2.0 RELEASED: TOPS LINUXTHREADS AND NPTL IN
 SCALABILITY AND PERFORMANCE
To: Bill Abt <babt@us.ibm.com>
Cc: pthreads-announce@www-124.southbury.usf.ibm.com,
       pthreads-core@www-124.southbury.usf.ibm.com,
       pthreads-devel@www-124.southbury.usf.ibm.com,
       pthreads-users@www-124.southbury.usf.ibm.com,
       linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OFD021A392.2FDB9E5D-ON87256CAB.00072F44@us.ibm.com>
From: Saurabh Desai <sdesai@us.ibm.com>
Date: Fri, 10 Jan 2003 18:28:11 -0700
X-MIMETrack: Serialize by Router on D03NM121/03/M/IBM(Release 6.0 [IBM]|December 16, 2002) at
 01/10/2003 18:28:13
MIME-Version: 1.0
Content-type: multipart/mixed; 
	Boundary="0__=08BBE638DF94A9D48f9e8a93df938690918c08BBE638DF94A9D4"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0__=08BBE638DF94A9D48f9e8a93df938690918c08BBE638DF94A9D4
Content-type: text/plain; charset=US-ASCII






The benchmark program (pingpong) developed by Sun Microsystem can be found
at
 http://wwws.sun.com/software/whitepapers/solaris9/multithread.pdf

This patch is needed to compile and run under Linux.

(See attached file: pingpong.c.diff)

Thanks,
- - - - -
Saurabh Desai



--0__=08BBE638DF94A9D48f9e8a93df938690918c08BBE638DF94A9D4
Content-type: application/octet-stream; 
	name="pingpong.c.diff"
Content-Disposition: attachment; filename="pingpong.c.diff"
Content-transfer-encoding: base64

LS0tIHBpbmdwb25nLmMub3JpZwlGcmkgSmFuIDEwIDE5OjAzOjQ1IDIwMDMKKysrIHBpbmdwb25n
LmMJRnJpIEphbiAxMCAxOTowNDo1OCAyMDAzCkBAIC03LDcgKzcsNyBAQAogICogKiBjYyAtbXQg
LXhhcmNoPXY5IC14TzQgcHAuYyAtbyBwcDY0IC1scHRocmVhZCAtbHJ0CiAgKiAqLwogI2luY2x1
ZGUgPHB0aHJlYWQuaD4KLSNpbmNsdWRlIDx0aHJlYWQuaD4KKy8qICNpbmNsdWRlIDx0aHJlYWQu
aD4gKi8KICNpbmNsdWRlIDxzdGRsaWIuaD4KICNpbmNsdWRlIDxzdHJpbmdzLmg+CiAjaW5jbHVk
ZSA8c3RkaW8uaD4KQEAgLTY5LDcgKzY5LDcgQEAKIG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3Zb
XSkKIHsKIAlpbnQgYzsKLQlocnRpbWVfdCB0MDsKKwlzdHJ1Y3QgdGltZXZhbCB0MCwgdDE7CiAJ
aW50IG50YWJsZXMgPSAxOwogCWludCB0YXJnZXQgPSAxMDAwMDAwOwogCWludCBzbGVlcG1zID0g
MDsKQEAgLTE1OSwyNyArMTU5LDMxIEBACiAJYmFycmllcl9pbml0KCZiZWdpbl9iYXJyaWVyLCAo
MiAqIG50YWJsZXMpICsgMSk7CiAJYmFycmllcl9pbml0KCZlbmRfYmFycmllciwgKDIgKiBudGFi
bGVzKSArIDEpOwogCS8qIHNob3VsZCBub3QgYmUgbmVlZGVkIC0gc2lnaCEgKi8KLQlpZiAoY29u
Y3VycmVuY3kgPiAwKSB7Ci0JCSh2b2lkKSB0aHJfc2V0Y29uY3VycmVuY3koY29uY3VycmVuY3kp
OwotCX0KKwkvL2lmIChjb25jdXJyZW5jeSA+IDApIHsKKwkJLy8odm9pZCkgdGhyX3NldGNvbmN1
cnJlbmN5KGNvbmN1cnJlbmN5KTsKKwkvL30KIAkvKiBpbml0aWFsaXNlIGFsbCBnYW1lcyAqLwot
CXQwID0gZ2V0aHJ0aW1lKCk7CisJZ2V0dGltZW9mZGF5KCZ0MCwgTlVMTCk7CiAJc2V0dXBfdGFi
bGVzKG50YWJsZXMsIHRhcmdldCwgc2xlZXBtcyk7CiAJCiAJLyogd2FpdCBmb3IgYWxsIHBsYXll
cnMgdG8gYmUgcmVhZHkgKi8KIAliYXJyaWVyX3dhaXQoJnNldHVwX2JhcnJpZXIpOwogCWlmICh2
ZXJib3NlKSB7Ci0JCSh2b2lkKSBwcmludGYoIiVkIHRocmVhZHMgaW5pdGlhbGlzZWQgaW4gJWxs
ZG1zXG4iLAotCQkJICAgICAgbnRhYmxlcyAqIDIsIChnZXRocnRpbWUoKSAtIHQwKS8xMDAwMDAw
TEwpOworCQlnZXR0aW1lb2ZkYXkoJnQxLCBOVUxMKTsKKwkJdGltZXJzdWIoJnQxLCAmdDAsICZ0
MSk7CisJCSh2b2lkKSBwcmludGYoIiVkIHRocmVhZHMgaW5pdGlhbGlzZWQgaW4gJWRzLiVkbXNc
biIsCisJCQkgICAgICBudGFibGVzICogMiwgdDEudHZfc2VjLCB0MS50dl91c2VjKTsKIAl9CiAJ
Lyogc3RhcnQgYWxsIGdhbWVzICovCi0JdDAgPSBnZXRocnRpbWUoKTsKKwlnZXR0aW1lb2ZkYXko
JnQwLCBOVUxMKTsKIAliYXJyaWVyX3dhaXQoJmJlZ2luX2JhcnJpZXIpOwogCS8qIHdhaXQgZm9y
IGFsbCBnYW1lcyB0byBjb21wbGV0ZSAqLwogCWJhcnJpZXJfd2FpdCgmZW5kX2JhcnJpZXIpOwog
CWlmICh2ZXJib3NlKSB7Ci0JCSh2b2lkKSBwcmludGYoIiVkIGdhbWVzIGNvbXBsZXRlZCBpbiAl
bGxkbXNcbiIsCi0JCQkgICAgICBudGFibGVzLCAoZ2V0aHJ0aW1lKCkgLSB0MCkvMTAwMDAwMExM
KTsKKwkJZ2V0dGltZW9mZGF5KCZ0MSwgTlVMTCk7CisJCXRpbWVyc3ViKCZ0MSwgJnQwLCAmdDEp
OworCQkodm9pZCkgcHJpbnRmKCIlZCBnYW1lcyBjb21wbGV0ZWQgaW4gJWRzLiVkbXNcbiIsCisJ
CQkgICAgICBudGFibGVzLCAgdDEudHZfc2VjLCB0MS50dl91c2VjKTsKIAl9CiAJcmV0dXJuICgw
KTsKIH0K

--0__=08BBE638DF94A9D48f9e8a93df938690918c08BBE638DF94A9D4--

