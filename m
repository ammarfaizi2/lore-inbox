Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272008AbTHDRYK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 13:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272038AbTHDRYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 13:24:10 -0400
Received: from p68.rivermarket.wintek.com ([208.13.56.68]:36062 "EHLO dust")
	by vger.kernel.org with ESMTP id S272008AbTHDRV5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 13:21:57 -0400
Date: Mon, 4 Aug 2003 12:25:38 -0500 (EST)
From: Alex Goddard <agoddard@purdue.edu>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Slightly Rearrange README File
Message-ID: <Pine.LNX.4.56.0308041214300.3506@dust>
X-GPG-PUBLIC_KEY: N/a
X-GPG-FINGERPRINT: BCBC 0868 DB78 22F3 A657 785D 6E3B 7ACB 584E B835
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463779740-190145915-1060017738=:3506"
Content-ID: <Pine.LNX.4.56.0308041224050.3506@dust>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463779740-190145915-1060017738=:3506
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.56.0308041224051.3506@dust>

This was suggested by a user yesterday.  I am not sure whom this should go
to, so it's going to the list in general.

Currently, the instructions for installing a kernel source tree are
followed by a section for software requirements in the README file.  This
seems a bit backwards.

The attached patch simply moves the "SOFTWARE REQUIREMENTS" section to
before the kernel installation, configuration, and compilation
instructions.

-- 
Alex Goddard
agoddard@purdue.edu
---1463779740-190145915-1060017738=:3506
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="README-rearrange.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.56.0308041225380.3506@dust>
Content-Description: 
Content-Disposition: attachment; filename="README-rearrange.patch"

LS0tIHBlcnNvbmFsLTIuNi4wLXRlc3QyLWJrMy9SRUFETUUub2xkCTIwMDMt
MDgtMDQgMTI6MDg6MjguMzk3NzI2MjE2IC0wNTAwDQorKysgcGVyc29uYWwt
Mi42LjAtdGVzdDItYmszL1JFQURNRQkyMDAzLTA4LTA0IDEyOjEyOjAyLjkw
MjExNjU5MiAtMDUwMA0KQEAgLTQ5LDYgKzQ5LDE3IEBAIERPQ1VNRU5UQVRJ
T046DQogICAgQWZ0ZXIgaW5zdGFsbGF0aW9uLCAibWFrZSBwc2RvY3MiLCAi
bWFrZSBwZGZkb2NzIiwgb3IgIm1ha2UgaHRtbGRvY3MiDQogICAgd2lsbCBy
ZW5kZXIgdGhlIGRvY3VtZW50YXRpb24gaW4gdGhlIHJlcXVlc3RlZCBmb3Jt
YXQuDQogDQorU09GVFdBUkUgUkVRVUlSRU1FTlRTDQorDQorICAgQ29tcGls
aW5nIGFuZCBydW5uaW5nIHRoZSAyLjUueHgga2VybmVscyByZXF1aXJlcyB1
cC10by1kYXRlDQorICAgdmVyc2lvbnMgb2YgdmFyaW91cyBzb2Z0d2FyZSBw
YWNrYWdlcy4gIENvbnN1bHQNCisgICAuL0RvY3VtZW50YXRpb24vQ2hhbmdl
cyBmb3IgdGhlIG1pbmltdW0gdmVyc2lvbiBudW1iZXJzIHJlcXVpcmVkDQor
ICAgYW5kIGhvdyB0byBnZXQgdXBkYXRlcyBmb3IgdGhlc2UgcGFja2FnZXMu
ICBCZXdhcmUgdGhhdCB1c2luZw0KKyAgIGV4Y2Vzc2l2ZWx5IG9sZCB2ZXJz
aW9ucyBvZiB0aGVzZSBwYWNrYWdlcyBjYW4gY2F1c2UgaW5kaXJlY3QNCisg
ICBlcnJvcnMgdGhhdCBhcmUgdmVyeSBkaWZmaWN1bHQgdG8gdHJhY2sgZG93
biwgc28gZG9uJ3QgYXNzdW1lIHRoYXQNCisgICB5b3UgY2FuIGp1c3QgdXBk
YXRlIHBhY2thZ2VzIHdoZW4gb2J2aW91cyBwcm9ibGVtcyBhcmlzZSBkdXJp
bmcNCisgICBidWlsZCBvciBvcGVyYXRpb24uDQorICAgDQogSU5TVEFMTElO
RyB0aGUga2VybmVsOg0KIA0KICAtIElmIHlvdSBpbnN0YWxsIHRoZSBmdWxs
IHNvdXJjZXMsIHB1dCB0aGUga2VybmVsIHRhcmJhbGwgaW4gYQ0KQEAgLTk3
LDE3ICsxMDgsNiBAQCBJTlNUQUxMSU5HIHRoZSBrZXJuZWw6DQogDQogICAg
WW91IHNob3VsZCBub3cgaGF2ZSB0aGUgc291cmNlcyBjb3JyZWN0bHkgaW5z
dGFsbGVkLg0KIA0KLVNPRlRXQVJFIFJFUVVJUkVNRU5UUw0KLQ0KLSAgIENv
bXBpbGluZyBhbmQgcnVubmluZyB0aGUgMi41Lnh4IGtlcm5lbHMgcmVxdWly
ZXMgdXAtdG8tZGF0ZQ0KLSAgIHZlcnNpb25zIG9mIHZhcmlvdXMgc29mdHdh
cmUgcGFja2FnZXMuICBDb25zdWx0DQotICAgLi9Eb2N1bWVudGF0aW9uL0No
YW5nZXMgZm9yIHRoZSBtaW5pbXVtIHZlcnNpb24gbnVtYmVycyByZXF1aXJl
ZA0KLSAgIGFuZCBob3cgdG8gZ2V0IHVwZGF0ZXMgZm9yIHRoZXNlIHBhY2th
Z2VzLiAgQmV3YXJlIHRoYXQgdXNpbmcNCi0gICBleGNlc3NpdmVseSBvbGQg
dmVyc2lvbnMgb2YgdGhlc2UgcGFja2FnZXMgY2FuIGNhdXNlIGluZGlyZWN0
DQotICAgZXJyb3JzIHRoYXQgYXJlIHZlcnkgZGlmZmljdWx0IHRvIHRyYWNr
IGRvd24sIHNvIGRvbid0IGFzc3VtZSB0aGF0DQotICAgeW91IGNhbiBqdXN0
IHVwZGF0ZSBwYWNrYWdlcyB3aGVuIG9idmlvdXMgcHJvYmxlbXMgYXJpc2Ug
ZHVyaW5nDQotICAgYnVpbGQgb3Igb3BlcmF0aW9uLg0KLQ0KIENPTkZJR1VS
SU5HIHRoZSBrZXJuZWw6DQogDQogIC0gRG8gYSAibWFrZSBjb25maWciIHRv
IGNvbmZpZ3VyZSB0aGUgYmFzaWMga2VybmVsLiAgIm1ha2UgY29uZmlnIiBu
ZWVkcw0K

---1463779740-190145915-1060017738=:3506--
