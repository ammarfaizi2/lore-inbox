Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272093AbRHVTVo>; Wed, 22 Aug 2001 15:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272098AbRHVTVe>; Wed, 22 Aug 2001 15:21:34 -0400
Received: from ffke-campus-gw.mipt.ru ([194.85.82.65]:6533 "EHLO
	www.2ka.mipt.ru") by vger.kernel.org with ESMTP id <S272093AbRHVTVV>;
	Wed, 22 Aug 2001 15:21:21 -0400
Message-Id: <200108221921.f7MJLPl28103@www.2ka.mipt.ru>
Date: Wed, 22 Aug 2001 23:21:29 +0400
From: Evgeny Polyakov <johnpol@2ka.mipt.ru>
To: Eli Carter <eli.carter@inet.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] typo in comment
In-Reply-To: <3B840002.60D13CEF@inet.com>
In-Reply-To: <3B840002.60D13CEF@inet.com>
Reply-To: johnpol@2ka.mipt.ru
X-Mailer: stuphead ver. 0.5.3 (Wiskas) (GTK+ 1.2.7; Linux 2.4.9; i686)
Organization: MIPT
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Wed__22_Aug_2001_23:21:29_+0400_081a7268"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Wed__22_Aug_2001_23:21:29_+0400_081a7268
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit

Hello.

On Wed, 22 Aug 2001 13:54:58 -0500
Eli Carter <eli.carter@inet.com> wrote:

EC> Alan, (& etc.)

EC> No, it's not terribly important, but in studying the networking code,
EC> I
EC> noticed it, so here's a patch against 2.2.19.  Please apply.  (It's
EC> attached to avoid possible mangling problems.)

EC> Comments, questions, complaints?

And here is one more patch, which fixing one warning in esssolo1.c and
against 2.4.9
It's like yours: one -, one +
:))

EC> Eli 

---
WBR. //s0mbre

--Multipart_Wed__22_Aug_2001_23:21:29_+0400_081a7268
Content-Type: text/plain;
 name="esssolo1.patch"
Content-Disposition: attachment;
 filename="esssolo1.patch"
Content-Transfer-Encoding: base64

LS0tIC90bXAvbGludXgvZHJpdmVycy9zb3VuZC9lc3Nzb2xvMS5jCVdlZCBBdWcgMjIgMDE6NDA6
NTUgMjAwMQorKysgLi9kcml2ZXJzL3NvdW5kL2Vzc3NvbG8xLmMJV2VkIEF1ZyAyMiAxNzozNTox
MyAyMDAxCkBAIC0yMjYyLDcgKzIyNzksNyBAQAogc29sbzFfc3VzcGVuZChzdHJ1Y3QgcGNpX2Rl
diAqcGNpX2RldiwgdTMyIHN0YXRlKSB7CiAJc3RydWN0IHNvbG8xX3N0YXRlICpzID0gKHN0cnVj
dCBzb2xvMV9zdGF0ZSopcGNpX2dldF9kcnZkYXRhKHBjaV9kZXYpOwogCWlmICghcykKLQkJcmV0
dXJuOworCQlyZXR1cm4gLTE7CiAJb3V0YigwLCBzLT5pb2Jhc2UrNik7CiAJLyogRE1BIG1hc3Rl
ciBjbGVhciAqLwogCW91dGIoMCwgcy0+ZGRtYWJhc2UrMHhkKTsgCg==

--Multipart_Wed__22_Aug_2001_23:21:29_+0400_081a7268--
