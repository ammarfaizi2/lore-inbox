Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265375AbUBGLof (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 06:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266853AbUBGLof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 06:44:35 -0500
Received: from lmdeliver02.st1.spray.net ([212.78.202.115]:7817 "EHLO
	lmdeliver02.st1.spray.net") by vger.kernel.org with ESMTP
	id S265375AbUBGLoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 06:44:34 -0500
From: "chacuncherche sonchat " <udok@caramail.com>
To: linux-kernel@vger.kernel.org
Message-ID: <1076154272015535@lycos-europe.com>
X-Mailer: LycosMail 
X-Originating-IP: [62.145.51.6]
Mime-Version: 1.0
Subject: Re: usb mouse/keyboard problems under 2.6.2
Date: Sat, 07 Feb 2004 12:44:32 +0100
Content-Type: multipart/mixed; boundary="=_NextPart_Lycos_0155351076154272_ID"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

--=_NextPart_Lycos_0155351076154272_ID
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> More specifically, 2.6.2-rc1-bk3 appears to be the earliest affected version. I haven't had a chance to try
backing out individual patches, so I don't yet know which particular update causes my problem.

I think you talk about a problem I have.
Since 2.6.2-rc2 (I didn't use 2.6.1-rc1-bk3), my mouse turns crazy from time to time, it's during about 2 seconds,
and I get this message in my logs :
kernel: psmouse.c: Explorer Mouse at isa0060/serio1/input0 lost synchronization, throwing 3 bytes away.

I think this thread talks about the same problem :
http://lkml.org/lkml/2004/2/7/8

E-mail, Dialogue en direct et SMS gratuits sur minitel : 3615 CARAMAIL


--=_NextPart_Lycos_0155351076154272_ID--

