Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317493AbSFMITo>; Thu, 13 Jun 2002 04:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317492AbSFMITn>; Thu, 13 Jun 2002 04:19:43 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:52927 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S317493AbSFMITn>; Thu, 13 Jun 2002 04:19:43 -0400
From: "BALBIR SINGH" <balbir.singh@wipro.com>
To: "'lkml'" <linux-kernel@vger.kernel.org>
Subject: Recall: [RFC] down and down_interruptible on x86
Date: Thu, 13 Jun 2002 13:52:57 +0530
Message-ID: <!~!UENERkVCMDkAAQACAJQAAAAAAAAAOKG7EAXlEBqhuwgAKypWwgAAbXNwc3QuZGxsAAAAAABOSVRB+b+4AQCqADfZbgAAAEM6XERvY3VtZW50cyBhbmQgU2V0dGluZ3NcV2lwcm8xXExvY2FsIFNldHRpbmdzXEFwcGxpY2F0aW9uIERhdGFcTWljcm9zb2Z0XE91dGxvb2tcb3V0bG9vay5wc3QAGAAAAAAAAADztfKJAGsARowwVZSJmQIKAoIAABgAAAAAAAAA87XyiQBrAEaMMFWUiZkCCgRVLAAAAAAAAAAAACkAAABbUkZDXSBkb3duIGFuZCBkb3duX2ludGVycnVwdGlibGUgb24geDg2AA==@wipro.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_00C3_01C212E1.A02B77A0"
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-MS-TNEF-Correlator: 00000000F3B5F289006B00468C3055948999020AE4582C00
Expiry-Date: Sat, 15 Jun 2002 13:52:55 +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_00C3_01C212E1.A02B77A0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Balbir Singh would like to recall the message, "[RFC] down and =
down_interruptible on x86".
------=_NextPart_000_00C3_01C212E1.A02B77A0
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="winmail.dat"

eJ8+IjoIAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEIgAcAEwAAAElQTS5PdXRs
b29rLlJlY2FsbACCBgEDkAYAIAMAABMAAABAABUAsOSN2UUUwgEDACYAAQAAAAIBMQABAAAAEgEA
AFBDREZFQjA5AAEAAgCUAAAAAAAAADihuxAF5RAaobsIACsqVsIAAG1zcHN0LmRsbAAAAAAATklU
Qfm/uAEAqgA32W4AAABDOlxEb2N1bWVudHMgYW5kIFNldHRpbmdzXFdpcHJvMVxMb2NhbCBTZXR0
aW5nc1xBcHBsaWNhdGlvbiBEYXRhXE1pY3Jvc29mdFxPdXRsb29rXG91dGxvb2sucHN0ABgAAAAA
AAAA87XyiQBrAEaMMFWUiZkCCgKCAAAYAAAAAAAAAPO18okAawBGjDBVlImZAgoEVSwAAAAAAAAA
AAApAAAAW1JGQ10gZG93biBhbmQgZG93bl9pbnRlcnJ1cHRpYmxlIG9uIHg4NgAAAAIBHQwBAAAA
HAAAAFNNVFA6QkFMQklSLlNJTkdIQFdJUFJPLkNPTQALAAEOAQAAAAMAFA4AAAAAAgEAaAEAAAAQ
AAAAn3eiVHTKkkOQVaWYPNYQYAMAAWgRAAAAHgACaAEAAAAJAAAASVBNLk5vdGUAAAAACwADaAEA
AAADAARoAAAAAAMAoYAIIAYAAAAAAMAAAAAAAABGAAAAABqFAAABAAAAAgH4DwEAAAAQAAAA87Xy
iQBrAEaMMFWUiZkCCgIB+g8BAAAAEAAAAPO18okAawBGjDBVlImZAgoCAfsPAQAAAJQAAAAAAAAA
OKG7EAXlEBqhuwgAKypWwgAAbXNwc3QuZGxsAAAAAABOSVRB+b+4AQCqADfZbgAAAEM6XERvY3Vt
ZW50cyBhbmQgU2V0dGluZ3NcV2lwcm8xXExvY2FsIFNldHRpbmdzXEFwcGxpY2F0aW9uIERhdGFc
TWljcm9zb2Z0XE91dGxvb2tcb3V0bG9vay5wc3QAAwD+DwUAAAADAA00/TcCAAIBFDQBAAAAEAAA
AE5JVEH5v7gBAKoAN9luAAACAX8AAQAAADEAAAAwMDAwMDAwMEYzQjVGMjg5MDA2QjAwNDY4QzMw
NTU5NDg5OTkwMjBBRTQ1ODJDMDAAAAAADsg=


------=_NextPart_000_00C3_01C212E1.A02B77A0
Content-Type: text/plain;
	name="Wipro_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Wipro_Disclaimer.txt"

**************************Disclaimer************************************

Information contained in this E-MAIL being proprietary to Wipro Limited is 
'privileged' and 'confidential' and intended for use only by the individual
 or entity to which it is addressed. You are notified that any use, copying 
or dissemination of the information contained in the E-MAIL in any manner 
whatsoever is strictly prohibited.

***************************************************************************

------=_NextPart_000_00C3_01C212E1.A02B77A0--

