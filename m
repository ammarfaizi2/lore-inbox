Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261872AbSLBJj2>; Mon, 2 Dec 2002 04:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261900AbSLBJj2>; Mon, 2 Dec 2002 04:39:28 -0500
Received: from 24.213.60.109.up.mi.chartermi.net ([24.213.60.109]:12713 "EHLO
	front3.chartermi.net") by vger.kernel.org with ESMTP
	id <S261872AbSLBJj1>; Mon, 2 Dec 2002 04:39:27 -0500
Date: Mon, 2 Dec 2002 04:46:27 -0500 (EST)
From: Nathaniel Russell <root@chartermi.net>
X-X-Sender: root@reddog.example.net
To: reddog83@chartermi.net
cc: linux-kernel@vger.kernel.org
Subject: Help with Via 8233 AC'97 Audio 
Message-ID: <Pine.LNX.4.44.0212020441180.1347-300000@reddog.example.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1905388979-1038822387=:1347"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-1905388979-1038822387=:1347
Content-Type: TEXT/PLAIN; charset=US-ASCII

I was woundering if you could help me get my Via AC'97 Sound Card to work
in 2.4.20+ it would be most appreciated because that is the only sound
card my computer has in it. I've googled around but i keep coming out with
a binary only driver for a RedHat System and i don't run RedHat I run
Slackware-9.0-beta1. So if possible would you please help me out.
Thank you inadavnce.
Nathaniel

--8323328-1905388979-1038822387=:1347
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=t
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0212020446270.1347@reddog.example.net>
Content-Description: lspci output
Content-Disposition: attachment; filename=t

MDA6MDAuMCBIb3N0IGJyaWRnZTogVklBIFRlY2hub2xvZ2llcywgSW5jLiBW
VDg2MzMgW0Fwb2xsbyBQcm8yNjZdIChyZXYgMDEpDQowMDowMS4wIFBDSSBi
cmlkZ2U6IFZJQSBUZWNobm9sb2dpZXMsIEluYy4gVlQ4NjMzIFtBcG9sbG8g
UHJvMjY2IEFHUF0NCjAwOjA4LjAgTXVsdGltZWRpYSBhdWRpbyBjb250cm9s
bGVyOiBFbnNvbmlxIEVTMTM3MCBbQXVkaW9QQ0ldDQowMDowOS4wIEV0aGVy
bmV0IGNvbnRyb2xsZXI6IEQtTGluayBTeXN0ZW0gSW5jIFJUTDgxMzkgRXRo
ZXJuZXQgKHJldiAxMCkNCjAwOjBhLjAgVVNCIENvbnRyb2xsZXI6IE5FQyBD
b3Jwb3JhdGlvbiBVU0IgKHJldiA0MSkNCjAwOjBhLjEgVVNCIENvbnRyb2xs
ZXI6IE5FQyBDb3Jwb3JhdGlvbiBVU0IgKHJldiA0MSkNCjAwOjBhLjIgVVNC
IENvbnRyb2xsZXI6IE5FQyBDb3Jwb3JhdGlvbiBVU0IgMi4wIChyZXYgMDIp
DQowMDoxMS4wIElTQSBicmlkZ2U6IFZJQSBUZWNobm9sb2dpZXMsIEluYy4g
VlQ4MjMzIFBDSSB0byBJU0EgQnJpZGdlDQowMDoxMS4xIElERSBpbnRlcmZh
Y2U6IFZJQSBUZWNobm9sb2dpZXMsIEluYy4gVlQ4MkM1ODZCIFBJUEMgQnVz
IE1hc3RlciBJREUgKHJldiAwNikNCjAwOjExLjIgVVNCIENvbnRyb2xsZXI6
IFZJQSBUZWNobm9sb2dpZXMsIEluYy4gVVNCIChyZXYgMTgpDQowMDoxMS4z
IFVTQiBDb250cm9sbGVyOiBWSUEgVGVjaG5vbG9naWVzLCBJbmMuIFVTQiAo
cmV2IDE4KQ0KMDA6MTEuNCBVU0IgQ29udHJvbGxlcjogVklBIFRlY2hub2xv
Z2llcywgSW5jLiBVU0IgKHJldiAxOCkNCjAwOjExLjUgTXVsdGltZWRpYSBh
dWRpbyBjb250cm9sbGVyOiBWSUEgVGVjaG5vbG9naWVzLCBJbmMuIFZUODIz
MyBBQzk3IEF1ZGlvIENvbnRyb2xsZXIgKHJldiAxMCkNCjAxOjAwLjAgVkdB
IGNvbXBhdGlibGUgY29udHJvbGxlcjogblZpZGlhIENvcnBvcmF0aW9uIE5W
NiBbVmFudGFdIChyZXYgMTUpDQo=
--8323328-1905388979-1038822387=:1347
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=t1
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0212020446271.1347@reddog.example.net>
Content-Description: lspci -n output
Content-Disposition: attachment; filename=t1

MDA6MDAuMCBDbGFzcyAwNjAwOiAxMTA2OjMwOTEgKHJldiAwMSkNCjAwOjAx
LjAgQ2xhc3MgMDYwNDogMTEwNjpiMDkxDQowMDowOC4wIENsYXNzIDA0MDE6
IDEyNzQ6NTAwMA0KMDA6MDkuMCBDbGFzcyAwMjAwOiAxMTg2OjEzMDAgKHJl
diAxMCkNCjAwOjBhLjAgQ2xhc3MgMGMwMzogMTAzMzowMDM1IChyZXYgNDEp
DQowMDowYS4xIENsYXNzIDBjMDM6IDEwMzM6MDAzNSAocmV2IDQxKQ0KMDA6
MGEuMiBDbGFzcyAwYzAzOiAxMDMzOjAwZTAgKHJldiAwMikNCjAwOjExLjAg
Q2xhc3MgMDYwMTogMTEwNjozMDc0DQowMDoxMS4xIENsYXNzIDAxMDE6IDEx
MDY6MDU3MSAocmV2IDA2KQ0KMDA6MTEuMiBDbGFzcyAwYzAzOiAxMTA2OjMw
MzggKHJldiAxOCkNCjAwOjExLjMgQ2xhc3MgMGMwMzogMTEwNjozMDM4IChy
ZXYgMTgpDQowMDoxMS40IENsYXNzIDBjMDM6IDExMDY6MzAzOCAocmV2IDE4
KQ0KMDA6MTEuNSBDbGFzcyAwNDAxOiAxMTA2OjMwNTkgKHJldiAxMCkNCjAx
OjAwLjAgQ2xhc3MgMDMwMDogMTBkZTowMDJjIChyZXYgMTUpDQo=
--8323328-1905388979-1038822387=:1347--
