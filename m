Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262055AbTCRBQ1>; Mon, 17 Mar 2003 20:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262070AbTCRBQ1>; Mon, 17 Mar 2003 20:16:27 -0500
Received: from mail.gmx.de ([213.165.65.60]:21572 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S262055AbTCRBQ1>;
	Mon, 17 Mar 2003 20:16:27 -0500
From: "Marijn Kruisselbrink" <marijnk@gmx.net>
To: <linux-kernel@vger.kernel.org>
Subject: RE: (2.5.65) Unresolved symbols in modules?
Date: Tue, 18 Mar 2003 02:27:20 +0100
Message-ID: <HJEOKOJLKINBOCDGFDOOMEOBCCAA.marijnk@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <1047950384.12620.18.camel@rohan.arnor.net>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - module-init-tools documentation stated if it is or is not backward
> compatible for the 2.4 kernels  (is it?)
If you have a new enough version of modutils, and you rename these to
depmod.old modprobe.old etcetera, they are backwards-compatible...

> - The kernel makefile used the module tools under /usr/local/sbin if
> they exist.
I totally agree with this.

