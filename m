Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbTDUPG3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 11:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbTDUPG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 11:06:29 -0400
Received: from mx03.cyberus.ca ([216.191.240.24]:29452 "EHLO mx03.cyberus.ca")
	by vger.kernel.org with ESMTP id S261309AbTDUPG1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 11:06:27 -0400
Date: Mon, 21 Apr 2003 11:18:17 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: linux-kernel@vger.kernel.org
Subject: 2.5.68 issues (X windows startup)
Message-ID: <20030421111032.O11939@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1677142396-1050938297=:11939"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--0-1677142396-1050938297=:11939
Content-Type: TEXT/PLAIN; charset=US-ASCII



I havent booted 2.5.x for a while on this dusty old laptop.
Never had this issue in the past. Have a feeling its some basic
utility that maybe needed.

--
model name      : Pentium III (Coppermine)
stepping        : 10
cpu MHz         : 696.996
cache size      : 256 KB
---

128M RAM.

When i run 2.5.68 theres a feel of highly improved interactiveness.
Annoyingly- Starting X takes at least 3 minutes (this is about a factor of
10 worse than older 2.5 and current 2.4.21-pre5. I have tried a few
2.5.6x and they all seem to exhibit this problem. Havent tried going back
beyond that.

I cleared the profile before running X; started X and captured the
profile right after that. Dont know if its any help, but it is attached.

cheers,
jamal
--0-1677142396-1050938297=:11939
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=j1
Content-Transfer-Encoding: BASE64
Content-ID: <20030421111817.A11939@shell.cyberus.ca>
Content-Description: 
Content-Disposition: attachment; filename=j1

IDE5NDU2IHRvdGFsICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAwLjEzMDQNCiAxNzcyMSBkZWZhdWx0X2lkbGUgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIDMxNi40NDY0DQogIDE0MTEgcnVuX3RpbWVyX3Nv
ZnRpcnEgICAgICAgICAgICAgICAgICAgICAgICAgIDIuOTY0Mw0KICAgIDYy
IGRvX3NvZnRpcnEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAw
LjI5ODENCiAgICA1NSBzZXRfYml0bWFwICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgMC4yOTI2DQogICAgNTEgc3lzdGVtX2NhbGwgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIDEuMTU5MQ0KICAgIDI1IGdlbmVy
YWxfcHJvdGVjdGlvbiAgICAgICAgICAgICAgICAgICAgICAgICAyLjA4MzMN
CiAgICAxOCBfX3dha2VfdXAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgMC4xMzY0DQogICAgMTQgc2NoZWR1bGUgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIDAuMDEwNg0KICAgIDExIHNhdmVfdjg2X3N0
YXRlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAwLjAyODENCiAgICAx
MCBzeXNfaW9wbCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
MC4xMDQyDQogICAgIDkgZG9fc3lzX3ZtODYgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIDAuMDI5Ng0KICAgICA5IGRvX3BhZ2VfZmF1bHQgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAwLjAwODcNCiAgICAgOCBhZGRf
d2FpdF9xdWV1ZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMC4wNjA2
DQogICAgIDYgc3lzX2lvcGVybSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIDAuMDIwNQ0KICAgICA1IHJlbW92ZV93YWl0X3F1ZXVlICAgICAg
ICAgICAgICAgICAgICAgICAgICAwLjA0MzENCiAgICAgNSBoYW5kbGVfdm04
Nl9mYXVsdCAgICAgICAgICAgICAgICAgICAgICAgICAgMC4wMDIwDQogICAg
IDQgc3lzX3ZtODZvbGQgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IDAuMDE1Mg0KICAgICA0IHJlc3RfaW5pdCAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAwLjAzNDUNCiAgICAgMyBlcnJvcl9jb2RlICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgMC4wNTM2DQogICAgIDIgc2V0
X210cnIgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDAuMDA1
NA0KICAgICAyIHNjaGVkdWxlX3RpbWVvdXQgICAgICAgICAgICAgICAgICAg
ICAgICAgICAwLjAxMTYNCiAgICAgMiBlbmFibGVfaXJxICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgMC4wMDg2DQogICAgIDIgZG9fZ2VuZXJh
bF9wcm90ZWN0aW9uICAgICAgICAgICAgICAgICAgICAgIDAuMDE4NQ0KICAg
ICAyIGRlbF90aW1lciAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAwLjAwOTYNCiAgICAgMiBhZGRfdGltZXIgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgMC4wMTE0DQogICAgIDEgc3lzX2dldHRpbWVvZmRh
eSAgICAgICAgICAgICAgICAgICAgICAgICAgIDAuMDA2Mw0KICAgICAxIHNp
Z3Byb2NtYXNrICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAwLjAw
MzINCiAgICAgMSByZXN1bWVfdXNlcnNwYWNlICAgICAgICAgICAgICAgICAg
ICAgICAgICAgMC4wNDE3DQogICAgIDEgcmVsZWFzZV90YXNrICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIDAuMDAyNg0KICAgICAxIHJlbGVhc2Vf
Y29uc29sZV9zZW0gICAgICAgICAgICAgICAgICAgICAgICAwLjAwMzQNCiAg
ICAgMSBvbGRfbW1hcCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgMC4wMDMzDQogICAgIDEgbW1faW5pdCAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIDAuMDAzNg0KICAgICAxIG1lbV9wYXJpdHlfZXJy
b3IgICAgICAgICAgICAgICAgICAgICAgICAgICAwLjAyMjcNCiAgICAgMSBl
eGl0X25vdGlmeSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMC4w
MDA2DQogICAgIDEgZG9fZ2V0dGltZW9mZGF5ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIDAuMDA2NA0KICAgICAxIGRlbF90aW1lcl9zeW5jICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAwLjAwODENCiAgICAgMSBjb3B5X3By
b2Nlc3MgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMC4wMDAzDQog
ICAgIDEgY29weV9maWxlcyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIDAuMDAxMA0K

--0-1677142396-1050938297=:11939--
