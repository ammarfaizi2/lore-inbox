Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbUBVE4o (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 23:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261153AbUBVE4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 23:56:44 -0500
Received: from lmdeliver01.st1.spray.net ([212.78.202.210]:16262 "EHLO
	lmdeliver01.st1.spray.net") by vger.kernel.org with ESMTP
	id S261152AbUBVE4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 23:56:42 -0500
From: "udok paldoswitz " <udok@caramail.com>
To: linux-kernel@vger.kernel.org
Message-ID: <1077425800011708@lycos-europe.com>
X-Mailer: LycosMail 
X-Originating-IP: [210.97.121.1]
Mime-Version: 1.0
Subject: Re: 2.6.3-ck1
Date: Sun, 22 Feb 2004 05:56:40 GMT 
Content-Type: multipart/mixed; boundary="=_NextPart_Lycos_0117081077425800_ID"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

--=_NextPart_Lycos_0117081077425800_ID
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Gstreamer doesn't work anymore with ck1.
I tried with elevator=3Ddeadline, but it does not solve the problem.
Gstreamer works fine with kernel 2.6.3

I tested it with several programs which use gstreamer (rhythmbox, gst-launch, etc ...),
but I get no error message.

Symptoms are :
I get no sound when I try to play a sound file.
The system is slowing down a lot.
When gstreamer stops, the system come back to a good state.

Plus simple, plus fiable, plus rapide : d=E9couvrez le nouveau Caramail - http://www.caramail.lycos.fr


--=_NextPart_Lycos_0117081077425800_ID--

