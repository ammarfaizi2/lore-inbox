Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317306AbSHAXDn>; Thu, 1 Aug 2002 19:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317312AbSHAXDn>; Thu, 1 Aug 2002 19:03:43 -0400
Received: from web9808.mail.yahoo.com ([216.136.129.34]:24839 "HELO
	web9808.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S317306AbSHAXDm>; Thu, 1 Aug 2002 19:03:42 -0400
Message-ID: <20020801230710.56990.qmail@web9808.mail.yahoo.com>
Date: Thu, 1 Aug 2002 16:07:10 -0700 (PDT)
From: Frank Wang <frankwang60@yahoo.com>
Subject: PROBLEM: "make dep" fails for version 2.4.18-5
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1071375854-1028243230=:55428"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-1071375854-1028243230=:55428
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Just got the 2.4.18-5 patched from Redhat.  The "make
dep" failes somewhere in the middle of the process. 
The error message indicates

xargs -f .....

The -f is a wrong option for the xargs.  The ver_linux
output is attached.  Any help is greatly appreciated.

Frank


__________________________________________________
Do You Yahoo!?
Yahoo! Health - Feel better, live better
http://health.yahoo.com
--0-1071375854-1028243230=:55428
Content-Type: application/octet-stream; name="va_linux.out"
Content-Transfer-Encoding: base64
Content-Description: va_linux.out
Content-Disposition: attachment; filename="va_linux.out"

SWYgc29tZSBmaWVsZHMgYXJlIGVtcHR5IG9yIGxvb2sgdW51c3VhbCB5b3Ug
bWF5IGhhdmUgYW4gb2xkIHZlcnNpb24uCkNvbXBhcmUgdG8gdGhlIGN1cnJl
bnQgbWluaW1hbCByZXF1aXJlbWVudHMgaW4gRG9jdW1lbnRhdGlvbi9DaGFu
Z2VzLgogCkxpbnV4IEZyYW5rTGludXggMi40LjE4LTVzbXAgIzEgU01QIE1v
biBKdW4gMTAgMTU6MTk6NDAgRURUIDIwMDIgaTY4NiB1bmtub3duCiAKR251
IEMgICAgICAgICAgICAgICAgICAyLjk2CkdudSBtYWtlICAgICAgICAgICAg
ICAgMy43OS4xCnV0aWwtbGludXggICAgICAgICAgICAgMi4xMW4KbW91bnQg
ICAgICAgICAgICAgICAgICAyLjExbgptb2R1dGlscyAgICAgICAgICAgICAg
IDIuNC4xNAplMmZzcHJvZ3MgICAgICAgICAgICAgIDEuMjcKcmVpc2VyZnNw
cm9ncyAgICAgICAgICAzLnguMGoKTGludXggQyBMaWJyYXJ5ICAgICAgICAy
LjIuNQpEeW5hbWljIGxpbmtlciAobGRkKSAgIDIuMi41ClByb2NwcyAgICAg
ICAgICAgICAgICAgMi4wLjcKTmV0LXRvb2xzICAgICAgICAgICAgICAxLjYw
CkNvbnNvbGUtdG9vbHMgICAgICAgICAgMC4zLjMKU2gtdXRpbHMgICAgICAg
ICAgICAgICAyLjAuMTEKTW9kdWxlcyBMb2FkZWQgICAgICAgICBsb29wIG5s
c19pc284ODU5LTEgaXBjaGFpbnMgc3JfbW9kIGNkcm9tIHNvdW5kY29yZSBh
dXRvZnMgM2M1OXggdXNiLXVoY2kgdXNiY29yZSBleHQzIGpiZCBhaWM3eHh4
IHNkX21vZCBzY3NpX21vZAo=

--0-1071375854-1028243230=:55428--
