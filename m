Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263812AbTLECm7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 21:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263823AbTLECm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 21:42:59 -0500
Received: from bay7-dav37.bay7.hotmail.com ([64.4.10.94]:60944 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S263812AbTLECm5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 21:42:57 -0500
X-Originating-IP: [24.61.138.213]
X-Originating-Email: [jason_kingsland@hotmail.com]
From: "Jason Kingsland" <Jason_Kingsland@hotmail.com>
To: "David Schwartz" <davids@webmaster.com>
Cc: <linux-kernel@vger.kernel.org>
References: <MDEHLPKNGKAHNMBLJOLKKEGMIHAA.davids@webmaster.com>
Subject: Re: Linux GPL and binary module exception clause?
Date: Thu, 4 Dec 2003 21:43:01 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Message-ID: <BAY7-DAV37GkZcFUjvZ0000328a@hotmail.com>
X-OriginalArrivalTime: 05 Dec 2003 02:42:56.0160 (UTC) FILETIME=[7CD66200:01C3BAD9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> My personal view is that Linux should mandate GPL for all modules in 2.6
and beyond.

"David Schwartz" wrote:
> I'm baffled how you think this is a choice that can be made. The license
is
> the GPL itself and even the Linux kernel developers have no power to
change it.

Modules are essentially dynamically linked extensions to the GPL kernel. In
some cases they can be shown to be independent, prior works where GPL can
reasonably be argued not to apply - which as Linus stated earlier on this
thread was the original intention of allowing binary-only modules.

But in most of the more recent cases the driver/module code is written
specifically for Linux, so it seems more appropriate that they would be
considered as derived works of the kernel. But those various comments from
Linus are being taken out of context to somehow justify permission for the
non-release of source code for binary loadable modules.

Linux is not pure GPL, it also has the Linus "user program" preamble in
copying.txt - that preamble plus other LKML posts from Linus are commonly
used as justifications for non-disclosure of source code to some classes of
modules.

But with all due respect, Linus is not the only author of Linux and his
words to tend to convey an artificial sense of authority or justification
for such attitudes. Here is a typical example:
http://www.linuxdevices.com/articles/AT9161119242.html

All I am suggesting is that the preamble could be extended to clearly state
the position for kernel binary-only modules, and that the upcoming 2.6
release might be an opportunity for a quorum of the Linux authors to agree
to revised wording.

