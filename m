Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262692AbTJKKMH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 06:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263273AbTJKKMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 06:12:07 -0400
Received: from smtp3.att.ne.jp ([165.76.15.139]:8836 "EHLO smtp3.att.ne.jp")
	by vger.kernel.org with ESMTP id S262692AbTJKKMF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 06:12:05 -0400
Message-ID: <242001c38fdf$fb165690$5cee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
References: <1f8801c38f11$da95c410$5cee4ca5@DIAMONDLX60> <20031010073750.001ad559.rddunlap@osdl.org>
Subject: Re: 2.6.0-test7 and HIDBP
Date: Sat, 11 Oct 2003 19:10:50 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap replied to me:

> | OK, I already know that I'm half-blind, but now either I'm 75% blind or
> | else these are facts:
> |    make xconfig has options for HIDBP.
> |    make gconfig doesn't.
> | Of course I want full HID so this might not matter, but I have memories
> | of needing HIDBP a few years ago.
>
> I don't know about gconfig, but you don't want or need HIDBP with full
> HID.

Indeed I don't want or need HIDBP with full HID, which is the reason I said
"so this might not matter".  Also I don't know if anyone still needs HIDBP
or not, which is the reason I said "I have memories of needing HIDBP a few
years ago".

Surely if anyone does still need HIDBP then it should be added to gconfig?
Surely if no one needs HIDBP any more then it should be deleted entirely?

Or maybe I'm 75% blind, maybe I it really is in gconfig and I couldn't see
it.  But no one has said that this is the case.

